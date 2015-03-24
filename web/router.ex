defmodule Showoff.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Showoff do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/publish", PageController, :publish
  end

  socket "/ws", Showoff do
    channel "svgs:index", SVGChannel
  end
end
