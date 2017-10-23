defmodule Microblog.Repo.Migrations.AddConstraintsToFollows do
  use Ecto.Migration

  def change do
    create unique_index(:follows, [:from_user_id, :to_user_id], name: :unique_follow_index)
  end
end
