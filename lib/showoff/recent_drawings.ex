defmodule Showoff.RecentDrawings do
  def start_link do
    Agent.start_link(fn -> Showoff.Examples.rendered_list end, name: __MODULE__)
  end

  def add_drawing(entry) when is_map(entry) do
    Agent.update(__MODULE__, fn (list) ->
      [entry | list] |> Enum.take(300)
    end)
  end

  def get_list do
    Agent.get(__MODULE__, &(&1))
  end
end
