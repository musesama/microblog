defmodule Microblog.Blog.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Blog.Like


  schema "likes" do
    belongs_to :user, Microblog.Accounts.User
    field :post_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
  end
end
