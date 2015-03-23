defmodule Showoff.PageController do
  use Showoff.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def circle(conn, _params) do
    svg = ChunkySVG.render([{:circle, %{cx: 50, cy: 50, r: 30}, nil}])
    Showoff.Endpoint.broadcast! "svgs:index", "svg:show", %{svg: svg}
    text conn, "OK"
  end
end
