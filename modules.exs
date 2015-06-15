# Elixir uses modules to group functions
# The macro defmodule is used to create a module
# within the module def is used to define functions
defmodule Math do
  def sum(a, b) do
    a + b
  end
end

Math.sum(1, 2) #=> 3

# Compilation
# To compile files you can use elixirc filename
# If we have a file named math.ex this will generate a file named Elixir.Math.beam
# Restarting iex from within the files directory will make it available

# Elixir projects are usually organized into 3 directories
  # 1) ebin -> contains the compiled bytecode
  # 2) lib -> contains elixir code(usually .ex files)
  # 3) test -> contains tests(usually .exs files)

# When working on actual projects the build tool mix is used
# It will compile code and set up the proper paths

# Elixir provides a Scripted mode
# These files have the file extension .exs
# They are treated the same as .ex, the only difference being .ex is meant to be compiled, while .exs doesn't require it

# Inside modules functions are defined with def/2 and defp/2
# When defined with def/2 those funtions can be called from other modules, defp/2 can only be invoked locally
defmodule Math do
  def sum(a, b) do
    a + b
  end

  defp do_sum(a, b) do
    a + b
  end
end

Math.sum(1, 2) #=> 3
Math.do_sum(1, 2) #=> ** (UndefinedFunctionError)

# Function declarations support guards and multiple clauses
# Elixir will try each clause until it finds one that matches
defmodule Math do
  def zero?(0) do
    true
  end

  def zero?(x) when is_number(x) do
    false
  end
end

Math.zero?(0) #=> true
Math.zero?(1) #=> false
Math.zero?([1, 2, 3]) #=> ** (FunctionClauseError)

# name/arity notation can also be used to retrieve a named function as a function type
Math.zero?(0) #=> true
fun = &Math.zero?/1 #=> &Math.zero?/1
is_function fun #=> true
fun.(0) #=> true

# Local or important functions can be captured without the module
&is_function/1 #=> &:erlang.is_function/1
(&is_function/1).(fun) #=> true

# Capture syntax can also be used as shortcut to create functions
fun = &(&1 + 1) #=> #Function<6.71889879/1 in :erl_eval.expr/5>
fun.(1) #=> 2

# &1 represents the first argument passed to the function
# &(&1 + 1) is the same as
fn x -> x + 1 end

# Same syntax can be used to call a function from a module doing &Module.function()
fun = &List.flatten(&1, &2) #=> &List.flatten/2
fun.([1, [[2], 3]], [4, 5]) #=> [1, 2, 3, 4, 5]
&List.flatten(&1, &2) == fn(list, tail) -> List.flatten(list, tail) end # They are the same

# Named functions also support default arguments
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

Concat.join("Hello", "world") #=> Hello world
Concat.join("Hello", "world", "_") #=> Hello_world

DefaultTest do
  def dowork(x \\ IO.puts "hello") do
    x
  end
end

DefaultTest.dowork #=> hello \n :ok
DefaultTest.dowork 123 #=> 123
DefaultTest.dowork #=> hello \n :ok

# If a function has multiple clauses it's best to create a function head for declaring defaults
defmodule Concat do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world") #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello world
IO.puts Contcat.join("Hello") #=> Hello

# When using default values must be wary of overlapping function definitions
defmodule Concat do
  def join(a, b) do
    IO.puts "***First join"
    a <> b
  end

  def join(a, b, sep \\ " ") do
    IO.puts "***Second join"
    a <> sep <> b
  end
end

# Would throw warning
# concat.ex:7: this clause cannot match because a previous clause at line 2 always matches
Concat.join "Hello", "world" #=> ***First join \n "Helloworld"
Concat.join "Hello", "world", "_" #=> ***Second join \n "Hello_world"
# Invoking join with 2 arguments will always choose the first definition
# While the second one will only be invoked when three arguments are passed
