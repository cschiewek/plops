defmodule Plops.Repo.Migrations.AddFieldsToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :enabled, :boolean
      add :slackbot_url, :string
      add :mark_as_read, :boolean
    end
  end
end
