defmodule Showoff do
  alias Showoff.Drawing

  def text_to_drawing(text) do
    case text_to_svg(text) do
      {:ok, svg} -> {:ok, %Drawing{svg: svg, text: text}}
      {:error, err} -> {:error, err}
    end
  end

  def text_to_svg(text) do
    case Showoff.TermParser.parse(text) do
      {:ok, term} -> term_to_svg(term)
      {:error, error} -> {:error, error}
    end
  end

  @doc "this should really be handled by ChunkySVG, but sometimes it just crashes when the structure does not match what it expects"
  def term_to_svg(term) do
    try do
      svg = ChunkySVG.render(term)
      {:ok, svg}
    catch
      err -> {:error, err}
      _reason, err -> {:error, err}
    end
  end
end
