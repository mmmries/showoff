defmodule ShowoffWeb.ScratchpadLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Tag
  require Logger

  def mount(%{}, socket) do
    socket = socket |> update_drawing("") |> assign(:drawing_text, "")
    {:ok, socket}
  end

  def handle_event("draw", %{"drawing_text" => text}, socket) do
    socket = socket |> update_drawing(text)
    {:noreply, socket}
  end
  def handle_event("example", text, socket) do
    socket = socket |> update_drawing(text) |> assign(:drawing_text, text)
    {:noreply, socket}
  end

  def handle_event("publish", data, socket) do
    Logger.info "publish #{inspect(data)}"
    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
      <div class="row">
        <h1>Scratchpad: Try Drawing Something!</h1>
      </div>

      <div class="row">
        <div class="screen" id="screen">
          <%= if @svg, do: {:safe, @svg} %>
        </div>
        <div class="input">
          <form phx-submit="publish" phx-change="draw">
            <textarea name="drawing_text"><%= @drawing_text %></textarea>
            <button name="action" value="publish">Publish This Drawing</button>
          </form>
          <p class="error"></p>
          <h4>Examples - Click to Try Them Out</h4>
          <div class="row examples">
            <%= for example <- Showoff.Examples.rendered_list() do %>
              <%= content_tag(:div, {:safe, example.svg}, class: "example", phx_click: "example", phx_value: example.drawing_text) %>
            <% end %>
          </div>
        </div>
      </div>

      <div class="row">
        <h1>Recent Published Drawings</h1>
      </div>

      <div class="row recents">
        <%= for recent <- Showoff.RecentDrawings.get_list() do %>
          <div class="example">
            <%= {:safe, recent.svg} %>
          </div>
        <% end %>
      </div>
    """
  end

  defp update_drawing(socket, text) do
    case Showoff.TermParser.parse(text) do
      {:ok, drawing_terms} ->
        svg = ChunkySVG.render(drawing_terms)
        assign(socket, :svg, svg)
      {:error, _err} ->
        assign(socket, :svg, nil)
    end
  end
end
