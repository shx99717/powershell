#################################################
# PowerShell Operators

# In this section, I will explain the commonly used operators supported by PowerShell. But It has a lot of operators. that I listed below,

# Arithmetic Operators (+, -, *, /, %)
# Assignment Operators (=, +=, -=, *=, /=, %=)
# Comparison Operators
# Equality Operators (-eq, -ne, -gt, -lt, -le, -ge)
# Matching Operators(-match, -notmatch, -replace)
# Containment comparison Operators (-in, -notin, -contains, -notcontains)
# Logical Operators (-and, -or, -xor, -not, !)
# Redirection Operators (>, >>, and >&1)
# Split and Join Operators (-split, -join)
# Type Operators (-is, -isnot, -as)
# Unary Operators (++, –)
# Special Operators

#####################################
# Arithmetic Operator
# +
6 + 2
"power" + "shell"

# -
8 - 9
-100

# *
100 * 2
"Ha" * 3  # repeat strings = HaHaHa

# /
9 / 7

# %
5 % 3



#####################################
# Assignment Operators
# =	Assign value to variable	
$a = 3

# += Adds and assign value to the variable
$a += 4
$b = "Hello, " # Concatenates string at the end
$b += "World"

# Adds number to array	
$a = 1,2,3
$a += 4 # 1,2,3,4

# -= Subtracts and assign value to the variable
$a -= 9

# *= Multiplies and assign value to the variable
$a *= 2

# /= Divides and assign a value to the variable
$a /= 7

# %= Divides and assign a remainder value to the variable
$a %= 3 