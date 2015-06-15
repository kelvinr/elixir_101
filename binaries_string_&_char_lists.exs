string = "hello" #=> "hello"
is_binary string #=> true

# UTF-8 & Unicode
# Unicode assigns code points to represent letters, a byte can only represent a number between 0-255 limiting a direct byte => code point mapping
# UTF-8 specifications encodes strings so we can represent code points without worrying about a bytes number limit
string = "hełło" #=> "hełło"
byte_size string #=> 7
String.length string #=> 5

# UTF-8 requires 1 byte to represent code points h, e, o
# However ł requires 2 bytes
# ? returns the code point's value
?a #=> 97
?ł #=> 322
String.codepoints("hełło") #=> ["h", "e", "ł", "ł", "o"]

# Binaries (and bitstrings)
<<>> # Defines a binary
<<0, 1, 2, 3>> #=> <<0, 1, 2, 3>>
byte_size <<0, 1, 2, 3>> #=> 4

String.valid?(<<239, 191, 191>>) #=> false

# String concat operator is actually binary concat operator
<<0, 1>> <> <<2, 3>> #=> <<0, 1, 2, 3>>

# A common trick is to concat <<0>>(null) to see inner binary representation
"hełło" <> <<0>> #=> <<104, 101, 197, 130, 197, 130, 111, 0>>

# Binaries allow modifiers to store numbers large than 255
<<255>> #=> <<255>>

<<256>> #=> <<0>> (truncated)
# use 16 bits to store the number
<<256 :: size(16)>> #=> <<1, 0>> (truncated)
<<256 :: utf8>> #=> "Ā" (this number is a code point)
<<256 :: utf8, 0>> #=> <<196, 128, 0>>

# Bitstrings
<<1 :: size(1)>> #=> <<1::size(1)>>
<<2 :: size(1)>> #=> <<0::size(1)>> #truncated
is_binary(<<1 :: size(1)>>) #=> false
is_bitstring(<<1 :: size(1)>>) #=> true
bit_size(<<1 :: size(1)>>) #=> 1
# It's now just a bitstring(a bunch of bits)
# A binary if a bitstring where the number of bits is divisable by 8

# Pattern matching binaries / bitstrings
<<0, 1, x>> = <<0, 1, 2>> #=> <<0, 1, 2>> 
x #=> 2
<<0, 1, x>> = <<0, 1, 2, 3>> #=> ** (MatchError) no match of right hand side value: <<0, 1, 2, 3>>

# Each entry in a binary is expected to be exactly 8 bits, but we can match on binary modifier
<<0, 1, x :: binary>> = <<0, 1, 2 ,3>> #=> <<0, 1, 2 ,3>> (would throw error without binary at end)
x #=> <<2, 3>

# Now in string concat
"he" <> rest = "hello" #=> "hello"
rest #=> "llo"

# Char lists
# Just a list of chars
'hełło' #=> [104, 101, 322, 322, 111]
is_list 'hełło' #=> true

# Only outputs codepoints if any chars are outside ASCII range
'hello' #=> 'hello'

# Char lists mostly used for interfacing with Erlang, especially old libraries that don't accept binaries
# Convert between char list and string with functions to_string/1 & to_char_list/1
to_char_list "hełło" #=> [104, 101, 322, 322, 111]
to_string 'hełło' #=> "hełło"
to_string :hello #=> "hello"
to_string 1 #=> "1"
