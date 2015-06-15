# Types
11 # Integer
0X1F # Integer
1.0 # Float
true # Boolean
:atom # Atom / Symbol
"Elixir" # String
[1, 2, 3] # List
{1, 2, 3} # Tuple

# h cmd for how to use shell, can also be given a function to print documentation

# Integers
1 + 2 #=> 3
5 * 5 #=> 25
10 / 2 #=> 5.0 / Always returns a float

div(10, 2) #=> 5
div 15, 3 #=> 5 parens are optional

rem 10, 3 #=> 1

# Elixir supports shorthand notations for binary, octal and hexadecimal numbers
0b10101 #=> 10
0o777 #=> 511
0x1F #=> 31

# Floats require a dot followed by atleast 1 num, e can be used for the exponent num
1.0 #=> 1.0
1.0e-10 #=> 1.0e-10

round 3.58 #=> 4
trunc 3.58 #=> 3

# Booleans
true #=> true
true == false #=> false

is_boolean(true) #=> true
is_boolean(1) #=> false

# Atoms
# Constants whose name is their own value, like symbols
:hello #=> :hello
:hello == :world #=> false

# Booleans are actually atoms
true == :true #=> true
is_atom(false) #=> true
is_boolean(:false) #=> true

# Strings
# In double quotes
"hello" #=> "hello"

# Supports interpolated text
"hello #{:world}" #=> "hello world"

# Standard escape sequences
"hello
world" #=> "hello\nworld"

IO.puts "hello\nworld" #=> prints string, returns atom :ok

# Strings are represented as binaries
is_binary("hello") #=> true
byte_size("hellö") #=> 6

String.length("hellö") #=> 5
String.upcase("hellö") #=> "HELLÖ"

# Anonymous functions
# delimited by fn and end

add = fn a, b -> a + b end #=> #Function<12.71889879/2 in :erl_eval.expr/5>
is_function(add) #=> true
is_function(add, 2) #=> true
is_function(add, 1) #=> false, arity specific
# . is required between variables and parens when call anon functions
add.(1, 2) #=> 3

# Anon functions are closures and can access variables that are in scope when they are defined
add_two = fn a -> add.(a, 2) end
add_two.(2) #=> 4

# Variables assigned in functions do not affect surrounding env
x = 42 #=> 42
(fn -> x = 0 end).() #=> 0
x #=> 42

#(Linked) Lists
[1, 2, true, 3] #=> [1, 2, true, 3]
length [1, 2, 3] #=> 3

# Lists can be concatenated and subtracted with ++/2 & --/2
[1, 2, 3] ++ [4, 5, 6] #=> [1, 2, 3, 4, 5, 6]
[1, true, 2, false, 3, true] -- [true, false] #=> [1, 2, 3, true]

# Lists head and tail can be retrieved with functions hd/1 & tl/1
list = [1, 2, 3]
hd(list) #=> 1
tl(list) #=> [2, 3]

# Retrieving head or tail of empty list returns an error
hd [] #=> ** (ArgumentError) argument error

# Lists can return values in single quotes
[11, 12, 13] #=> 'v\f\r'

# Elixir will print ASCII numbers as a character list
[104, 101, 108, 108, 111]

# Single and double quotes are not equivalent
# Single == char lists, Double == strings
'hello' == "hello" #=> false

# Tuples
{:ok, "hello"} #=> {:ok, "hello"}

# Similar to Array, base 0 index based access
tuple = {:ok, "hello"} #=> {:ok, "hello"}
elem(tuple, 1) #=> "hello"
tuple_size(tuple) #=> 2

# Set an element at certain index using put_elem/3
put_elem(tuple, 1, "world") #=> {:ok, "world"}
# put_elem/3 returns a new tuple

# Elixir data types are immutable
tuple #=> {:ok, "hello"}

# Lists VS. Tuples
# Lists are stored as linked lists, each element holds its value amd points to the following elment
# Each pair is refered to as a cons cell
# Hence operations such as retrieving length is linear(the whole list must be traversed)
# Prepending is fast, just reset the head.. Appending is slow(list must be rebuilt)
list = [1, 2, 3]
[0] ++ list #=> [0, 1, 2, 3]
list ++ [4] #=> [1, 2, 3, 4]

# Tuples are stored in memory, accessing elements or operations such as size are very fast
# However adding or updating elements is expensive because it must be copied in memory
# Choose your data structure accordingly, for example reading files will return a tuple
File.read("path/to/a/file") #=> {:ok, "...contents..."}
File.read("path/to/unknown/file") #=> {:error, :enoent}
# If File.read/1 succeeds it returns :ok as first element and contents as second
# Otherwise returns :error as first element and description as second
