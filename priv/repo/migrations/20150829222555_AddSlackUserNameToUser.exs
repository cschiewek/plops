defmodule Plops.Repo.Migrations.AddSlackUserNameToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :slack_username, :string
    end
  end
end
