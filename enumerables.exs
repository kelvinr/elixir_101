# Elixir provides the Enum module

# Lists and maps
Enum.map([1, 2, 3], fn x -> x * 2 end) #=> [2, 4, 6]
Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) #=> [2, 12]

# Elixir provides ranges
Enum.map(1..3, fn x -> x * 2 end)
Enum.reduce(1..3, 0, &+/2)

# Enum module is designed to work across many data types
# Thus its API is limited to polymorphic functions
# Its functions are only available to data types implementing the Enumerable protocall

# Eager vs Lazy
# All Enum functions are eager, may expect an enumerable and return a list
odd? = &(rem(&1, 2) != 0) #=> #Function<6.80484245/1 in :erl_eval.expr/5>
Enum.filter(1..3, odd?) #=> [1, 3]

# When performing multiple operations with Enum, each operation will generate an intermediate list

1..100_000 |> Enum.map(&1 * 3)) |> Enum.filter(odd?) |> Enum.sum #=> 7500000000
# This is a pipeline of operations
# Starting with a range we then multiply each element by 3
# This creates and returns a list of 100_000 items
# Then kepp all odd elements from the list, generating a new list with 50_000 items
# Then we sum all entries

# The pipe operator |>
# The pipe operator simply takes output from an expression and passes it as the input to a function
# It's purpose is to highlight the flow of data being transformed by a series of functions
# Above example can be rewritten without |>
Enum.sum(Enum.filter(Enum.map(1..100_000, &(&1 * 3)), odd?)) #=> 7500000000

# Streams
# The stream module supports lazy operations
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum #=> 7500000000
# Streams are composable enumerables, instead of generating lists they provide a series of computations
# these are invoked only when we pass it to the Enum module
# They are useful for dealing with large, possibly infinite collections

# They are lazy because they return a data type
# An actual stream representing the computation

1..100_000 |> Stream.map(&(&1 * 3)) #=> #Stream<[enum: 1..100000, funs: [#Function<34.16982430/1 in Stream.map/2>]]>

# They are composable because we can pipe many stream operations
1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) #=> #Stream<[enum: 1..100000, funs: [...]]>

# Many functions in the Stream module accept any enumerable as the argument and return a stream
# It can even provide functions for creating possibly infinite stream
# Ex: Stream.cycle/1 can be used to create a stream that cycles a given enumerable infinitely
# Must be careful not to call functions such as Enum.map/2 on these streams as it would cycle forever

stream = Stream.cycle([1, 2, 3]) #=> #Function<15.16982430/2 in Stream.cycle/1>
Enum.take(stream, 10) #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Stream.unfold/2 can be used to generate values from an initial value
stream = Stream.unfold("hełło", &String.next_codepoint/1) #=> #Function<39.75994740/2 in Stream.unfold/2>
Enum.take(stream, 3) #=> ["h", "e", "ł"]

# Stream.resource/3 can wrap resources guaranteeing they are opened right before enumeration
# and closed afterwards, even in case of failures, very useful for files
stream = File.stream!("path/to/file") #=> #Function<18.16982430/2 in Stream.resource/3>
Enum.take(stream, 10)
# This will fetch the first 10 lines of a file, useful for large files or even slow network resources

