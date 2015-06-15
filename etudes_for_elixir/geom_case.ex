defmodule GeomCase do
  @moduledoc """
  Functions for calculating area of shapes.
  """

  @doc """
  Calculates area of a shape, given the shape and two
  dimensions.
  """

  @spec area(atom(), number(), number()) :: number()

  def area(shape, x, y) when x >= 0 and y >= 0 do
    case shape do
      :rectangle -> x * y
      :triangle -> x * y / 2.0
      :ellipse -> :math.pi * x * y
    end
  end
end
