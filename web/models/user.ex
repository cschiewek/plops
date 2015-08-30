defmodule Plops.User do
  use Plops.Web, :model
  alias Plops.Repo
  alias Plops.User

  schema "users" do
    field :name, :string
    field :github_login, :string
    field :access_token, :string
    field :enabled, :boolean
    field :slack_username, :string
    field :slack_webhook_url, :string
    field :mark_as_read, :boolean

    timestamps
  end

  @required_fields ~w(name github_login access_token)
  @optional_fields ~w(enabled slack_username slack_webhook_url mark_as_read)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def enabled, do: Repo.all(from user in User, where: user.enabled)
end
