defmodule Showoff.PageController do
  use Showoff.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def publish(conn, %{"drawing_text" => drawing_text}) do
    case Showoff.TermParser.parse(drawing_text) do
      {:ok, drawing_terms} ->
        svg = ChunkySVG.render(drawing_terms)
        Showoff.Endpoint.broadcast! "svgs:index", "svg:show", %{svg: svg}
        text conn, "OK"
      {:error, err} ->
        conn |> put_status(422) |> json %{error: err}
    end
  end
end
