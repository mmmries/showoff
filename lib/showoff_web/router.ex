defmodule ShowoffWeb.Router do
  use ShowoffWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", ShowoffWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/show/:drawing_text", PageController, :show
  end
end
