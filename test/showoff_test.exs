defmodule ShowoffTest do
  use ExUnit.Case

  test "parsing erlang terms" do
    text = "[{circle, \#\{cx => 50, cy => 50, r => 40}, nil}]."
    expected = {:ok, [{:circle, %{cx: 50, cy: 50, r: 40}, nil}]}
    assert Showoff.PageController.parse_erlang_terms(text) == expected
  end
end
