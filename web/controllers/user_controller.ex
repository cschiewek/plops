defmodule Plops.UserController do
  use Plops.Web, :controller

  def edit(conn, _params) do
    render conn, "edit.html"
  end
end
