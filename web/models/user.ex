defmodule Plops.User do
  use Plops.Web, :model

  schema "users" do
    field :name, :string
    field :github_login, :string
    field :access_token, :string

    timestamps
  end

  @required_fields ~w(name github_login access_token)
  @optional_fields ~w()

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
