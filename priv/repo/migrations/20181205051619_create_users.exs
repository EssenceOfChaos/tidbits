defmodule Tidbits.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :display_name, :string
      add :email, :string
      add :password_hash, :string
      add :is_admin, :boolean, default: false, null: false
      add :avatar, :string

      timestamps()
    end

  end
end
