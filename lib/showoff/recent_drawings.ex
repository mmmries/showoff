defmodule Showoff.RecentDrawings do
  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link do
    Agent.start_link(fn -> Showoff.Examples.rendered_list end, name: __MODULE__)
  end

  def add_drawing(entry) when is_map(entry) do
    Agent.update(__MODULE__, fn (list) ->
      [entry | list] |> Enum.take(300)
    end)
    ShowoffWeb.Endpoint.broadcast(
      "recent_drawings",
      "update",
      %{recent: get_list()}
    )
  end

  def get_list do
    Agent.get(__MODULE__, &(&1))
  end
end
