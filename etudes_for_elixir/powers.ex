defmodule AccumulatePowers do
  import Kernel, except: [raise: 2, raise: 3]

  def raise(_,n) when n == 0 do
    1
  end

  def raise(x, 1) do
    x
  end

  def raise(x, n) when n > 0 do
    raise(x, n, 1)
  end

  def raise(x, n) when n < 0 do
    1.0 / raise(x, -n)
  end

  defp raise(_, 0, accumulator) do
    accumulator
  end

  defp raise(x, n, accumulator) do
    raise(x, n - 1, x * accumulator)
  end

  def nth_root(x, n) do
    nth_root(x, n, x / 2.0)
  end

  defp nth_root(x, n, a) do
    IO.puts("Current guess is #{a}")
    f = raise(a, n) - x
    f_prime = n * raise(a, n - 1)
    next = a - f / f_prime
    change = abs(next - a)
    cond do
      change < 1.0e-8 -> next
      true -> nth_root(x, n, next)
    end
  end
end
