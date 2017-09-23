defmodule Microblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :poster, :string
      add :content, :text
      add :likes, :integer
      add :comment, :integer

      timestamps()
    end

  end
end
