defmodule TidbitsWeb.PageControllerTest do
  use TidbitsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to tidbits!"
  end
end
