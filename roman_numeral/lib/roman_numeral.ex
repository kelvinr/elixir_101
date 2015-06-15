defmodule RomanNumeral do

  @numerals [{1000, "M"}, {500, "D"}, {100, "C"}, {50, "L"}, {10, "X"}, {9, "IX"}, {5, "V"}, {4, "IV"}, {1, "I"}]

  def converts(number), do: converts(number, @numerals)

  defp converts(number, _) when number < 1 do
    ""
  end

  defp converts(number, [{arabic, roman} | tail]) when number >= arabic do
    roman <> converts(number - arabic, [{arabic, roman} | tail])
  end

  defp converts(number, [_ | tail]) do
    converts(number, tail) 
  end
end
