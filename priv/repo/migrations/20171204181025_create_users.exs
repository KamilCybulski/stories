defmodule Stories.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password_hash, :string
      add :description, :string
      add :img, :string

      timestamps()
    end

  end
end
