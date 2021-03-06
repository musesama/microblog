defmodule Microblog.Accounts.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Follow


  schema "follows" do
    field :from_user_id, :id
    field :to_user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:from_user_id, :to_user_id])
    |> validate_required([:from_user_id, :to_user_id])
    |> unique_constraint(:to_user_id, name: :unique_follow_index)
  end
end
