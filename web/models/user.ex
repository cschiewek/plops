defmodule Plops.User do
  use Plops.Web, :model

  schema "users" do
    field :name, :string
    field :github_login, :string
    field :access_token, :string
    field :enabled, :boolean
    field :slack_domain, :string
    field :slack_username, :string
    field :slackbot_token, :string
    field :mark_as_read, :boolean

    timestamps
  end

  @required_fields ~w(name github_login access_token)
  @optional_fields ~w(enabled slack_domain slackbot_token slack_username mark_as_read)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
