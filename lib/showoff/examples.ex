defmodule Showoff.Examples do
  def list do
    [
      "{:circle, %{cx: 50, cy: 50, r: 40}, nil}",
      "{:triangle, %{cx: 50, cy: 50, r: 40}}",
      "{:hexagon, %{cx: 50, cy: 50, r: 40}}",
      "[\n  {:triangle, %{cx: 50, cy: 40, r: 50, transform: \"rotate(180, 50,50)\", fill: \"green\"}},\n  {:triangle, %{cx: 50, cy: 60, r: 25, fill: \"white\"}},\n]",
    ]
  end

  def rendered_list do
    list |> Enum.map fn (drawing_text) ->
      {:ok, drawing_terms} = Showoff.TermParser.parse(drawing_text)
      %{drawing_text: drawing_text, svg: ChunkySVG.render(drawing_terms)}
    end
  end
end
