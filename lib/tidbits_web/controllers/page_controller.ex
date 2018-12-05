defmodule TidbitsWeb.PageController do
  use TidbitsWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn)
    render(conn, "index.html")
  end
end
