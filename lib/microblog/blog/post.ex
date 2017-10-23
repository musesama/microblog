defmodule Microblog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Post


  schema "posts" do
    field :content, :string
    belongs_to :user, Microblog.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content])
  end
end
