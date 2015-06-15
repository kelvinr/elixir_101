# In Elixir = is actually the match operator
x = 1 #=> 1
x #=> 1
1 = x #=> 1
2 = x #=> ** (MatchError) no match of right hand side value: 1

# Great for destructuring complex data types
{a, b, c} = {:hello, "world", 42} #=> {:hello, "world", 42}
a #=> :hello
b #=> "world"

{a, b, c} = {:hello, "world"} #=> ** (MatchError) no match of right handside value: {:hello, "world"}
{a, b, c} = [:hello, "world", "!"] #=> ** (MatchError) no match of right hand side value: [:hello, "world", "!"]

# Matching on specific values
{:ok, result} = {:ok, 13} #=> {:ok, 13}
result #=> 13

# Will only match a tuple begining with :ok
{:ok, result} = {:error, :oops} #=> ** (MatchError) no match of right hand side value: {:error, :oops}

# List aswell
[a, b, c] = [1, 2, 3] #=> [1, 2, 3]
a #=> 1

# Match lists on its own head and tail
[head | tail] = [1, 2, 3] #=> [1, 2, 3]
head #=> 1
tail #=> [2, 3]

# Matching empty list throws error
[h|t] = [] #=> ** (MatchError) no match of right hand side value: []

# Prepend on list
list = [1, 2, 3] #=> [1, 2, 3]
[0|list] #=> [0, 1, 2, 3]

# Variables can be rebound
x = 1 #=> 1
x = 2 #=> 2

# ^ pin operator used for matching against its value prior to match
x = 1 #=> 1
^x = 2 #=> ** (MatchError) no match of right hand side value: 2
{x, ^x} = {2, 1} #=> {2, 1}
x #=> 2

# Multiple varible mentions in a pattern bind to the same pattern
{x, x} = {1, 1} #=> 1
{x, x} = {1, 2} #=> ** (MatchError) no match of right hand side value: {1, 2}

# _ used as convention when we don't care about a certain value
[h | _] = [1, 2, 3] #=> [1, 2, 3]
h #=> 1

# _ variable is special, it can never be read from
_ #=>  ** (CompileError) iex:1: unbound variable _

# Functions cant be called on left side of match
length([1,[2],3]) = 3 #=> ** (CompileError) iex:1: illegal pattern
