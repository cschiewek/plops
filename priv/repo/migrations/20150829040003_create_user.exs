defmodule Plops.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :github_login, :string
      add :access_token, :string

      timestamps
    end

  end
end
