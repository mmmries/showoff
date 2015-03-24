defmodule Showoff.PageController do
  use Showoff.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def publish(conn, %{"drawing_text" => drawing_text}) do
    {:ok, drawing_terms} = parse_erlang_terms(drawing_text)
    svg = ChunkySVG.render(drawing_terms)
    Showoff.Endpoint.broadcast! "svgs:index", "svg:show", %{svg: svg}
    text conn, "OK"
  end

  def parse_erlang_terms(text) do
    {:ok, tokens, _} = text |> String.to_char_list |> :erl_scan.string
    {:ok, term} = :erl_parse.parse_term(tokens)
  end
end
