defmodule Plops.UserController do
  use Plops.Web, :controller
  alias Plops.User

  plug :scrub_params, "user" when action in [:update]

  def show(conn, _) do
    user = Repo.get(User, conn.assigns.current_user.id)
    notifications = GitHub.Client.notifications(user.access_token)
    render(conn, "show.html", user: user, notifications: notifications)
  end

  def edit(conn, _) do
    user = Repo.get(User, conn.assigns.current_user.id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = Repo.get(User, conn.assigns.current_user.id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        # TODO: Send test message to slack, wrapped in Task
        message = "User updated successfully.  A test message was sent to slack.
                   If you did not get a message from Plops in Slack, please check your settings"
        conn
        |> put_flash(:info, message)
        |> redirect(to: user_path(conn, :show))
      {:error, changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, _) do
    user = Repo.get(User, conn.assigns.current_user.id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> delete_session(:current_user)
    |> delete_session(:access_token)
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: page_path(conn, :index))
  end
end
