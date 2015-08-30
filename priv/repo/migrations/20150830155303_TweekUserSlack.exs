defmodule Plops.Repo.Migrations.TweekUserSlack do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :slack_domain
      remove :slackbot_token
      add :slack_webhook_url, :string
    end
  end
end
