# Loops through recursion
# Due to Elixir immutability loops are written differently from imperative languages
# EXAMPLE: JS
for(i = 0; i < array.length; i++) {
  array[i] = array[i] * 2
}
# This mutates both i and array, which is not possible in Elixir
# Recursion calls a function recursively until a condition is reach which stops it, no data is mutated

defmodule Recursion do
  def print_multiple_times(msg, n) when n <= 1 do
    IO.puts msg
  end

  def print_multiple_times(msg, n) do
    IO.puts msg
    print_multiple_times(msg, n -1)
  end
end

Recursion.print_multiple_times("Hello!", 3) #=> Hello! \n Hello! \n Hello!

# Breakdown
# Functions can take multiple clauses, a particular clause is executed when the arguments passed match the clause's argument patterns and the guard evaluates to true
# When print_multiple_times/2 was first called n == 3, guard evaluates to false
# Elixir proceeds to the next clause's definition, the pattern matches and has no guard, it will execute
# It prints the msg and calls itself passing n -1 (2) as the second argument
# It continues until n == 1
# Guard on first definition passes and that definition is executed, after which there is nothing left to execute
# print_multiple_times/2 is defined so that no matter the number passed it either triggers the first definition(base case)
# or triggers the second definition which ensures we get exactly 1 step closer to base case

# Reduce and map algorithms

# reduce algorithm
defmodule Math do
  def sum_list([head|tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end

IO.puts Math.sum_list([1, 2, 3], 0) #=> 6

# Breakdown
# sum_list is invoked with list [1, 2, 3] and initial value 0 as arguments
# We try each clause until we find one that matches according to pattern matching
# [1, 2, 3] matches against [head|tail], head = 1, tail = [2, 3], accumulator = 0
# head is added to accumulator, head + accumulator and call sum_list again
# passing the tail as the first argument and the result of head + accumulator as second argument
# the process repeats until the list is empty
# then second definition matches, which returns accumulator

sum_list [1, 2, 3], 0
sum_list [2, 3], 1
sum_list [3], 3
sum_list [], 6

# map algorithm
defmodule Math do
  def double_each([head|tail]) do
    [head * 2|double_each(tail)]
  end

  def double_each([]) do
    []
  end
end

Math.double_each([1, 2, 3]) #=> [2, 4, 6]

# Recursion and tail call optimization are important in Elixir
# However Elixir provides the Enum module, as a convenience for working with lists

Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end) #=> 6
Enum.map([1, 2, 3], fn(x) -> x * 2 end) #=> [2, 4, 6]

# With capture syntax
Enum.reduce([1, 2, 3], 0, &+/2) #=> 6
Enum.map([1, 2, 3], &(&1 * 2)) #=> [2, 4, 6]
