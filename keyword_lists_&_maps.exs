# Keyword Lists
# List of tuples where the first item of the tuple is an atom
list = [{:a, 1}, {:b, 2}] #=> [a: 1, b: 2]
list == [a: 1, b: 2] #=> true
list [:a] #=> 1

# Elixir supports this special syntax, underneath they are just a list of tuples
list ++ [c: 3] #=> [a: 1, b: 2, c: 3]
[a: 0] ++ list #=> [a: 0, a: 1, b: 2]

# Values added to the front are the ones fetched on lookup
new_list = [a: 0] ++ list #=> [a: 0, a: 1, b: 2]
new_list[:a] #=> 0

if false, do: :this, else: :that
# Is equivalent to
if (false, [do: :this, else: :that}])
# If keyword list is last argument, square brackets are optional

# Keyword lists share the same performance as lists, the longer the list the less performant
# Mostly used as options
# Keyword lists special characteristics include
  # 1) Keys must be atoms
  # 2) Keys are ordered
  # 3) Keys can be repeated
# For many items or unique keys maps are preferable

# Pattern matching keyword lists
# Rarely done because requires number of items and their order to match
[a: a] = [a: 1] #=> [a: 1]
a #=> 1
[a: a] = [a: 1, b: 2] #=> ** (MatchError) no match of right hand side value: [a: 1, b: 2]
[b: b, a: a] = [a: 1, b: 2] #=> ** (MatchError) no match of right hand side value: [a: 1, b: 2]

# Maps
# The go-to key-value store, created with %{}
map = %{:a => 1, 2 => :b} #=> %{:a => 1, 2 => :b}
map[:a] #=> 1
map[2] #=> :b
map[:c] #=> nil
# Maps differences from keyword lists
  # 1) Maps allow any value as key
  # 2) Keys do not follow any ordering

# If duplicate keys are passed last one wins
%{1 => 1, 1 => 2} #=> %{1 => 2}

# When all keys in a map are atoms you can use keyword syntax
%{a: 1, b: 2} #=> %{a: 1, b: 2} 

# Maps are very useful for pattern matching
%{} = %{:a => 1, 2 => :b} #=> %{:a => 1, 2 => :b}
%{:a => a} = %{:a => 1, 2 => :b} #=> %{:a => 1, 2 => :b}
a #=> 1
%{:c => c} = %{:a => 1, 2 => :b} #=> ** (MatchError) no match of right hand side value: %{2 => :b, :a => 1}

# Map module has a similar API to the Keyword module
Map.get(%{:a => 1, 2 => :b}, :a) #=> 1
Map.to_list(%{:a => 1, 2 => :b}) #=> [{2, :b}, {:a, 1}]

map = %{:a => 1, 2 => :b}
# Maps provide a special syntax for updating and accessing atom keys
map.a #=> 1
map.c #=> ** (KeyError) key :c not found in: %{2 => :b, :a => 1}

%{map | :a => 2} #=> %{:a => 2, 2 => :b}
%{map | :c => 3} #=> ** (ArgumentError) argument error
# Both access and update syntax require the key to exist

# Both keyword lists and Maps are dictionaries
# Both  implement the Dict module interface
keyword = [] #=> []
map = %{} #=> %{}
Dict.put(keyword, :a, 1) #=> [a: 1]
Dict.put(map, :a, 1) #=> %{a: 1}

# Dict allows you to implement your own variation of Dict and hook into existing Elixir code
# It also provides functions that work across dictionaries
# EXAMPLE: Dict.equal?/2 can compare 2 dictionaries of any kind

