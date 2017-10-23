defmodule MicroblogWeb.PostController do
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Accounts
  alias Microblog.Blog.Post

  def index(conn, %{"user_id" => user_id}) do
    posts = Blog.get_posts_by_user_id(user_id)
    render(conn, "index.html", posts: posts)
  end

  def index(conn, _params) do
    posts = Blog.list_posts() 
    user = conn.assigns[:current_user]
    if user do
      redirect(conn, to: user_post_path(conn, :index, user.id))
    else
      redirect(conn, to: page_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    user = conn.assigns[:current_user]
    if user == nil do
      redirect conn, to: page_path(conn, :index)
    end
    case Blog.create_post(Map.put(post_params, "user_id", user.id)) do
      {:ok, post} ->
        for f <- Accounts.get_followers(user.id) do
          MicroblogWeb.Endpoint.broadcast("updates:#{f}", "new_msg", post_params)
        end
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)

    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
