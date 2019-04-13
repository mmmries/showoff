defmodule ShowoffWeb.ScratchpadLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Tag
  require Logger

  def mount(%{}, socket) do
    if connected?(socket) do
      :ok = ShowoffWeb.Endpoint.subscribe("recent_drawings")
    end

    socket = socket
             |> update_drawing("")
             |> assign(:drawing_text, "")
             |> assign(:err, "")
             |> assign(:recent, Showoff.RecentDrawings.get_list())
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

  def handle_event("publish", %{"drawing_text" => text}, socket) do
    case Showoff.text_to_svg(text) do
      {:ok, svg} ->
        drawing = %{drawing_text: text, svg: svg}
        Showoff.RecentDrawings.add_drawing(drawing)
        {:noreply, assign(socket, :err, "")}
      {:error, _err} ->
        socket = socket |> assign(:err, "an error occured trying to draw that") |> assign(:drawing_text, text)
        {:noreply, socket}
    end
  end

  def handle_info(%{event: "update", payload: %{recent: recent}}, socket) do
    socket = assign(socket, :recent, recent)
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
          <p class="error"><%= @err %></p>
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
        <%= for recent <- @recent do %>
          <%= content_tag(:div, {:safe, recent.svg}, class: "example", phx_click: "example", phx_value: recent.drawing_text) %>
        <% end %>
      </div>
    """
  end

  defp update_drawing(socket, text) do
    case Showoff.text_to_svg(text) do
      {:ok, svg} ->
        assign(socket, :svg, svg)
      {:error, _err} ->
        assign(socket, :svg, nil)
    end
  end
end
