defmodule Plops.Plugs do
  defmacro __using__(_) do
    quote do
      def assign_current_user(conn, _) do
        assign(conn, :current_user, get_session(conn, :current_user))
      end

      def authorize(conn, _) do
        if conn.assigns.current_user do
          conn
        else
          conn
          |> put_status(404)
          |> put_view(Plops.ErrorView)
          |> render(:"404")
        end
      end
    end
  end
end
