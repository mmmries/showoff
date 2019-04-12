defmodule ShowoffWeb.PageController do
  use ShowoffWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
