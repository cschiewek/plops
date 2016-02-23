defmodule Plops.PageControllerTest do
  use Plops.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Plops"
  end
end
