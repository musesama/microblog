defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Blog
  alias Microblog.Blog.Like

  action_fallback MicroblogWeb.FallbackController

  def index(conn, %{"post_id" => post_id}) do
    likes = Blog.list_post_likes(post_id)
    render(conn, "index.json", likes: likes)
  end

  def index(conn, _params) do
    likes = Blog.list_likes()
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"like" => like_params}) do
    with {:ok, %Like{} = like} <- Blog.create_like(like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("show.json", like: like)
    end
  end

  def show(conn, %{"id" => id}) do
    like = Blog.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Blog.get_like!(id)

    with {:ok, %Like{} = like} <- Blog.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Blog.get_like!(id)
    with {:ok, %Like{}} <- Blog.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
