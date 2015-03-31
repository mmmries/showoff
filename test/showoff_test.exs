defmodule ShowoffTest do
  use ExUnit.Case
  use Plug.Test

  test "getting the examples" do
    response = conn(:get, "/examples") |> send_request
    data = Poison.decode!(response.resp_body)
    circle = data |> List.first
    drawing_terms = Showoff.TermParser.parse(circle["drawing_text"])
    assert {:ok, {:circle, %{cx: 50, cy: 50, r: 40}, nil}} == drawing_terms
  end

  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Showoff.Endpoint.call([])
  end
end
