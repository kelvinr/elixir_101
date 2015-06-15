defmodule Dijkstra do
  @moduledoc """
  Recursive function to calculate the GCD of two numbers using
  Dijkstra's algorithm.
  """

  @doc """
  Calculates the greates common divisor of two integers.
  Dijkstra's algorithm does not require any division.
  """
  @spec gcd(number(), number()) :: number()

  def gcd(m, n) when m == n do
    m
  end

  def gcd(m, n) when m > n do
    gcd(m - n, n)
  end

  def gcd(m, n) do
    gcd(m, n - m)
  end
end
