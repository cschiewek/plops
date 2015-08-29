defmodule Plops.PageController do
  use Plops.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
