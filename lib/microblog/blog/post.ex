defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :comment, :integer
    field :content, :string
    field :likes, :integer
    field :poster, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:poster, :content, :likes, :comment])
    |> validate_required([:poster, :content, :likes, :comment])
  end
end
