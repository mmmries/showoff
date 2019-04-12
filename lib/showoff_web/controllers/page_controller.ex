defmodule ShowoffWeb.PageController do
  use ShowoffWeb, :controller

  def index(conn, _params) do
    Phoenix.LiveView.Controller.live_render(conn, ShowoffWeb.ScratchpadLive, session: %{})
  end

  def show(conn, %{"drawing_text" => drawing_text}) do
    case Showoff.text_to_svg(drawing_text) do
      {:ok, svg} ->
        render conn, "show.html", svg: svg
      {:error, err} ->
        conn |> put_status(422) |> text "Sorry, I Can't Draw That\n#{err}"
    end
  end
end
