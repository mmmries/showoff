defmodule Showoff.SVGChannel do
  use Phoenix.Channel
  require Logger

  def join("svgs:index", _message, socket) do
    reply socket, "join", %{status: "connected"}
    {:ok, socket}
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end

  def handle_in("svg:show", message, socket) do
    broadcast! socket, "svg:show", message
    {:ok, socket}
  end

  def handle_out(event, message, socket) do
    reply socket, event, message
    {:ok, socket}
  end
end
