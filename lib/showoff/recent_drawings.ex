defmodule Showoff.RecentDrawings do
  alias Showoff.Drawing

  def add_drawing(%Drawing{}=drawing) do
    id = DateTime.utc_now() |> DateTime.to_unix(:millisecond)
    true = :dets.insert_new(__MODULE__, {id, drawing})
    publish_updated_list()
  end

  def list do
    :dets.match(__MODULE__, :"$1")
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.map(fn([{_id, drawing}]) -> drawing end)
  end

  defp publish_updated_list do
    ShowoffWeb.Endpoint.broadcast(
      "recent_drawings",
      "update",
      %{recent: list()}
    )
  end
end
