defmodule RomanNumeralTest do
  use ExUnit.Case

  test "converts arabic into roman numerals" do
    test_values = [{0, ""},
                   {1, "I"},
                   {2, "II"},
                   {3, "III"},
                   {4, "IV"},
                   {5, "V"},
                   {6, "VI"},
                   {9, "IX"},
                   {10, "X"},
                   {28, "XXVIII"},
                   {51, "LI"},
                   {134, "CXXXIV"},
                   {558, "DLVIII"},
                   {1556, "MDLVI"}]

    Enum.each test_values, fn({arabic, roman}) -> assert RomanNumeral.converts(arabic) == roman end
  end
end
