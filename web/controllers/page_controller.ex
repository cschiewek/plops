defmodule Plops.PageController do
  use Plops.Web, :controller

  def index(conn, _params) do
    if conn.assigns[:current_user] do
      redirect conn, to: user_path(conn, :show)
    else
      render conn, "index.html"
    end
  end
end
