# case compares may patterns until match is found
case {1, 2, 3} do
  {4, 5, 6} ->
    "This clause won't match"
  {1, x, 3} ->
    "This clause will match and bind x to 2 in this clause"
  ->
    "This clause will match any value"
end #=> "This clause will match and bind x to 2 in this clause"

# To match against an existing variable must use ^ operator
x = 1 #=> 1

case 10 do
  ^x -> "Won't match"
     -> "Will match"
end #=> "Will match"

# Clauses allow extra conditions via guards
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
    ->
      "Won't match"
end #=> "Will match"
# Will only math when x is positive

# If no clause matches an error is raised
case :ok do
  :error -> "Won't match"
end #=> ** (CaseClauseError) no case clause matching: :ok

# Anon functions can also have multiple clauses
f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end #=> #Function<12.71889879/2 in :erl_eval.expr/5>

f.(1, 2) #=> 4
f.(-1, 3) #=> -3
# Number of arguments must be the same, otherwise error is raised

# cond finds the first condition that evaluates to true
# similar to if, else if
cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end #=> "But this will"

# If no condition returns true an error is raised, adding a final true condition prevents this
cond do
  2 + 2 == 5 ->
    "This is never true"
  2 * 2 == 3 ->
    "Nor this"
  true ->
    "This is always true (equivalent to else)"
end #=> "This is always true (equivalent to else)"

# Any values apart from nil and false are true
cond do
  hd([1, 2, 3]) ->
    "1 is considered as true"
end #=> "1 is considered as true"

# Elixir also provides macros if/2 & unless/2
if true do
  "This works!"
end #=> "This works"

unless true do
  "This will never be seen"
end #=> nil

# Supports else blocks
if nil do
  "This won't be seen"
else
  "This will"
end #=> "This will"

# If can also be written inline
if true, do: 1 + 2 #=> 3

# In Elixir do/end is a convenience for passing expressions to do:
# These are equivalent
if true do
  a = 1 + 2
  a + 10
end #=> 13

if true do: (
  a = 1 + 2
  a + 10
) #=> 13

# Refered to as keyword lists
if false, do: :this, else :that #=> :that

# do/end blocks are always bound to outermost function call
is_number if true do
  1 + 2
end #=> ** (RuntimeError) undefined function: if/1

# This is parsed as
is_number(if true) do
  1 + 2
end #=> ** (RuntimeError) undefined function: if/1

# Explicitly add parens to eliminate ambiguity
is_number(if true do
  1 + 2
end)









