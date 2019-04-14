defmodule Showoff.Examples do
  @list [
    "#Any SVG shape can be represented as a {name, attributes, children} tuple\n{:circle, %{cx: 50, cy: 50, r: 40}, nil}",
    "#There are also shortcuts for some shapes not defined by SVG\n{:triangle, %{cx: 50, cy: 50, r: 40}}",
    "{:hexagon, %{cx: 50, cy: 50, r: 40}}",
    "#You can draw multiple shapes by putting them in a list\n[\n  {:octagon, %{cx: 50, cy: 50, r: 40, fill: \"orange\"}},\n  {:circle, %{cx: 12, cy: 12, r: 10}, nil},\n  {:circle, %{cx: 88, cy: 12, r: 10}, nil},\n  {:circle, %{cx: 12, cy: 88, r: 10}, nil},\n  {:circle, %{cx: 88, cy: 88, r: 10}, nil},\n  {:pentagon, %{\n    cx: 50,\n    cy: 50,\n    r: 30}},\n]",
    "[\n  #You can move or rotate shapes with a transform - see\n  #https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/transform for more details\n  {:triangle, %{cx: 50, cy: 40, r: 50, transform: \"rotate(180, 50,50)\", fill: \"green\"}},\n  {:triangle, %{cx: 50, cy: 60, r: 25, fill: \"white\"}},\n]",
    "[\n  {:polygon, %{points: \"50 90 100 10 0 10\", fill: \"red\"}, nil},\n  {:polygon, %{points: \"46 40 56 24 66 40\", fill: \"black\"}, nil},\n  {:polygon, %{points: \"34 40 44 24 50 31 44.3 40\", fill: \"black\"}, nil},\n  {:polygon, %{points: \"34 41 44 57 54 41\", fill: \"white\"}, nil},\n  {:polygon, %{points: \"66 41 56 57 50 50 55.7 41\", fill: \"white\"}, nil},\n]",
    "#There are shortcuts for :background and :hills if you're into landscapes\n[\n  {:background, \"lightblue\"},\n  {:hills, %{points: [{20,80},{40,70},{75,80},{100,85}], fill: \"lightgreen\", stroke: \"green\"}},\n  {:circle, %{cx: 75, cy: 25, r: 20, fill: \"yellow\", stroke: \"orange\"}, nil},\n]",
    "#Paths can be used to trace arbitrary shapes\n[\n  {:path, %{d: \"M1,80 L1,35 8,35 8,20 92,20 92,35 99,35 99,80 z\", fill: \"rgb(251,1,22)\", stroke: \"rgb(185,16,34)\", \"stroke-width\": \"4.5%\"}, nil},\n  {:path, %{d: \"M12,78.5 L12,66.5 32,70 88,65.5 88,78.5 z\", fill: \"rgb(185,16,34)\"}, nil},\n  {:path, %{d: \"M12,58.5 L12,40.5 50,40.5 68,54.5 88,40.5 88,58.5 32,62 z\", fill: \"rgb(185,16,34)\"}, nil},\n  {:path, %{d: \"M13,17.5 L13,25 17,28 3,33, 3,47 7,50 7,43 9,46 9,40.5 12,40.5 20,60 25,60.7 28,82 38,82 36,61.4 51,52 61,59 62.5,58.5 63,60.3 79,59 78,56 70,54 50,40 40,47 33,31 46,22 53,22 55,24 55,22  59,22 58,17 38,17 25,25 25,17 z\", fill: \"white\"}, nil},\n]",
    "[\n  # create a \":box\" shortcut to represent a small blue square\n  {:def, :box, {:rect, %{x: 0.2, y: 0.2, width: 9.6, height: 9.6, fill: \"blue\"}, nil}},\n \n  # create a \":row\" shortcut to represent a row of boxes\n  {:def, :row, {:g, %{}, [\n    {:box, %{transform: \"translate(0 , 0)\"}},\n    {:box, %{transform: \"translate(10, 0)\"}},\n    {:box, %{transform: \"translate(20, 0)\"}},\n    {:box, %{transform: \"translate(30, 0)\"}},\n    {:box, %{transform: \"translate(40, 0)\"}},\n    {:box, %{transform: \"translate(50, 0)\"}},\n    {:box, %{transform: \"translate(60, 0)\"}},\n    {:box, %{transform: \"translate(70, 0)\"}},\n    {:box, %{transform: \"translate(80, 0)\"}},\n    {:box, %{transform: \"translate(90, 0)\"}}\n  ]}},\n \n  # then we create 10 rows and move them to fill the view area\n  {:row, %{transform: \"translate(0,0)\"}},\n  {:row, %{transform: \"translate(0,10)\"}},\n  {:row, %{transform: \"translate(0,20)\"}},\n  {:row, %{transform: \"translate(0,30)\"}},\n  {:row, %{transform: \"translate(0,40)\"}},\n  {:row, %{transform: \"translate(0,50)\"}},\n  {:row, %{transform: \"translate(0,60)\"}},\n  {:row, %{transform: \"translate(0,70)\"}},\n  {:row, %{transform: \"translate(0,80)\"}},\n  {:row, %{transform: \"translate(0,90)\"}},\n]",
  ]

  def list do
    Enum.map(@list, fn (text) ->
      {:ok, drawing} = Showoff.text_to_drawing(text)
      drawing
    end)
  end
end
