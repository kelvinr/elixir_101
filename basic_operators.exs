# Arithmetic
+, -, *, /
div/2
rem/2

# String concat
"string 1" <> "string 2"

# Boolean
or, and, not
# Expect a boolean as first argument
true and true #=> true
false or is_atom(:example) #=> true
1 and true #=> ** (ArgumentError) argument error

# or & and are short-circuit operators(right side only executed if left isn't deterministic)

# Standard
||, &&, !
# Will accept any argument type
# Everything but false and nil is true

1 || true #=> 1
false || 11 #=> 11

nil && 13 #=> nil
true && 17 #=> 17

!true #=> false
!1 #=> false
!nil #=> true

# Comparison
==, !=, ===, !==, <=, >=, <, >
1 == 1 #=> true
1 != 2 #= true
1 < 2 #=> true

1 == 1.0 #=> true
1 === 1.0 #=> false

# Comparing different data types
1 < :atom #=> true

# Sort order
number < atom < reference < functions < port < pid < tuple < maps < list < bitstring





