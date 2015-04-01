defmodule Showoff.PageController do
  use Showoff.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def examples(conn, _params) do
    conn |> json Showoff.Examples.rendered_list
  end

  def recent(conn, _params) do
    conn |> json Showoff.RecentDrawings.get_list
  end

  def show(conn, %{"drawing_text" => drawing_text}) do
    drawing_text = URI.decode(drawing_text)
    case Showoff.TermParser.parse(drawing_text) do
      {:ok, drawing_terms} ->
        svg = ChunkySVG.render(drawing_terms)
        render conn, "show.html", svg: svg
      {:error, err} ->
        conn |> put_status(422) |> text "Sorry, I Can't Draw That\n#{err}"
    end
  end

  def publish(conn, %{"drawing_text" => drawing_text}) do
    case Showoff.TermParser.parse(drawing_text) do
      {:ok, drawing_terms} ->
        svg = ChunkySVG.render(drawing_terms)
        drawing = %{drawing_text: drawing_text, svg: svg}
        Showoff.Endpoint.broadcast! "svgs:index", "svg:show", drawing
        Showoff.RecentDrawings.add_drawing(drawing)
        json conn, drawing
      {:error, err} ->
        conn |> put_status(422) |> json %{error: err}
    end
  end

  def draw(conn, %{"drawing_text" => drawing_text}) do
    case Showoff.TermParser.parse(drawing_text) do
      {:ok, drawing_terms} ->
        svg = ChunkySVG.render(drawing_terms)
        json conn, %{svg: svg}
      {:error, err} ->
        conn |> put_status(422) |> json %{error: err}
    end
  end
end
