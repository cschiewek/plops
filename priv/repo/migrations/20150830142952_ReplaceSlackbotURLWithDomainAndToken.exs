defmodule Plops.Repo.Migrations.ReplaceSlackbotURLWithDomainAndToken do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :slackbot_url
      add :slack_domain, :string
      add :slackbot_token, :string
    end
  end
end
