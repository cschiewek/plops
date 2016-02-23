defmodule Plops.AuthenticationController do
  use Plops.Web, :controller
  alias Plops.User

  def index(conn, _params) do
    redirect conn, external: GitHub.authorize_url!(scope: "repo")
  end

  def callback(conn, %{"code" => code}) do
    # Exchange an auth code for an access token
    token = GitHub.get_token!(code: code)

    # Request the user's data with the access token
    github_user = OAuth2.AccessToken.get!(token, "/user").body

    # Find or create user
    user = Repo.get_by(User, github_login: github_user["login"])
    if user do
      user = update_user(user, token.access_token)
    else
      user = create_user(github_user, token.access_token)
    end

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, token.access_token)
    |> redirect(to: user_path(conn, :show))
  end

  def signout(conn, _params) do
    delete_session(conn, :current_user)
    |> delete_session(:access_token)
    |> put_flash(:info, "You have signed out.")
    |> redirect(to: page_path(conn, :index))
  end

  defp create_user(github_user, access_token) do
    attributes = %{
      name: github_user["name"], github_login: github_user["login"],
      access_token: access_token
    }
    changeset = User.changeset(%User{}, attributes)
    if changeset.valid?, do: user = changeset |> Repo.insert!
  end

  defp update_user(user, access_token) do
    changeset = User.changeset(user, %{ access_token: access_token })
    if changeset.valid?, do: user = changeset |> Repo.update!
  end
end
