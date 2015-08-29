defmodule Plops.Plugs do
  defmacro __using__(_) do
    quote do
      def assign_current_user(conn, _) do
        conn
          |> assign(:current_user, get_session(conn, :current_user))
          |> assign(:access_token, get_session(conn, :access_token))
      end

      def authenticate(conn, _) do
        if conn.assigns.current_user do
          conn
        else
          conn
            |> put_flash(:error, "You need to be signed in to view this page")
            |> redirect(to: "/")
            |> halt
        end
      end
    end
  end
end
