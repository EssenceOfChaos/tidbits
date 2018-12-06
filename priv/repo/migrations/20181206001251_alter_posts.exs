defmodule Tidbits.Repo.Migrations.AlterPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :tags, {:array, :string}
      add :editors_pick, :boolean
    end

  end
end
