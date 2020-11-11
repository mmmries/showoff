defmodule Showoff.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    open_recent_drawings_table()

    # List all child processes to be supervised
    children = [
      {Phoenix.PubSub, [name: Showoff.PubSub, adapter: Phoenix.PubSub.PG2]},
      ShowoffWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Showoff.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShowoffWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp open_recent_drawings_table do
    filename = Application.app_dir(:showoff)
               |> Path.join("priv/drawings/recent.dets")
               |> String.to_charlist()
    {:ok, _table_name} = :dets.open_file(Showoff.RecentDrawings, file: filename)
  end
end
