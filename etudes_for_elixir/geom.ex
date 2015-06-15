defmodule Geom do
  @moduledoc """
  Functions for calculating areas of geometric shapes.
  """

  @doc """
  Calculates the area of a rectangle, given the length and width.
  Returns the product of its arguments for rectangle, one half the product
  of the arguments for triangle and :math.pi times the product for ellipse.
  """

  @spec area({atom(), number(), number()}) :: number()

  def area({shape, dim1, dim2}) do
    area(shape, dim1, dim2)
  end

  # Individual functions to handle different shapes

  @spec area(atom(), number(), number()) :: number()

  defp area(:rectangle, len, width) when len >= 0 and width >= 0 do
    len * width
  end

  defp area(:triangle, base, height) when base >= 0 and height >= 0 do
    base * height / 2.0
  end

  defp area(:ellipse, len, width) when len >= 0 and width >= 0 do
    :math.pi() * len * width
  end

  defp area(_, _, _) do
    0
  end
end
