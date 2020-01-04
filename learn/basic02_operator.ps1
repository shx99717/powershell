#################################################
# PowerShell Operators
#################################################

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
#####################################

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
#####################################

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

#####################################
# Comparison operators
# By default, all comparison operators are case-insensitive. To make a comparison operator case-sensitive, 
# precede the operator name with a c. For example, the case-sensitive version of -eq is -ceq.
# To make the case-insensitivity explicit, precede the operator with an i. 
# For example, the explicitly case-insensitive version of -eq is -ieq. 
#####################################
# Check for equality of values. This includes numeric, strings, array. It will return True or False are a result.
# -eq
# Check for equal value	
1 -eq 1
# Check for equal arrays
# When the input to an operator is a scalar value, comparison operators return a Boolean value. 
# When the input is a collection of values, the comparison operators return any matching values. 	
1,2,3 -eq 2 # 2 will be returned which is the matching value
# Check for equal strings	
"Hello" -eq "World"

# -ne
# Check for non-equal value
1 -ne 2
# Check for non-equal arrays
1,2,3 -ne 2 # 1,3 will be the returned value, which is the matching values
# Check for non-equal strings
"Hello" -ne "World"

# -gt
# Check for greater value
8 -gt 6
# Check all greater values in array and prints one by one
7, 8, 9 -gt 8 # 9 will return, which is the matching value

# -ge
# Check for greater or equal value
8 -ge 8
# Check all greater values or equal values in array and prints one by one
7, 8, 9 -ge 8 # 8, 9 will return, which is the matching value

# -lt
# Check for lesser value
8 -lt 6
# Check all lesser values in array and prints one by one
7, 8, 9 -lt 8

# -le
# Check for lesser or equal value
6 -le 8
# Check all lesser values or equal values in array and prints one by one
7, 8, 9 -le 8

#####################################
# Matching operators
# These PowerShell operators are capable of finding elements with specific patterns using wild card expressions.
#####################################
# -match	
# Matches a string with a specified regular expression
"Sunday", "Monday", "Tuesday" -match "sun" # return Sunday
# -notmatch
# Does not match a string with a specified regular expression
"Sunday", "Monday", "Tuesday" -notmatch "sun" # return Monday, Tuesday
# -replace
# Check for the given string and replace with specified string
"book" -replace "B", "C"

#####################################
# Containment comparison operators
# This PowerShell Operators are used to checks for the existence of a specified element or array in an array.
#####################################
# -contains
# Checks for the existence of a specified element in an array
"red", "yellow" -contains "red"

# -notcontains
# Checks for the non-existence of specified element in an array
"red", "yellow" -notcontains "green"

# -in
# Checks for the existence of a specified element in an array
"red" -in "red", "yellow"

# -notin
# Checks for the non-existence of specified element in an array
"green" -notin "red", "yellow"

# Remark: Note: both contain and in do the same operation, the operand order differs, in "contains" we take 
# right-hand value to check against left-hand value. But in "in" we take left-hand value to check against right-hand value.

#####################################
# Logical operators
#####################################
# -and	
# Truth with both statements is TRUE.
1 -and 1
# -or
# Truth with any one of the statements is TRUE.
1 -or 0
# -xor
# Truth when only of the statement is TRUE.	1 -xor 0
# -not
# Negates the statement.
-not 1
# !
# Negates the statement	
!0
!1

#####################################
# Redirection operators
# This PowerShell Operator used to redirect the output of one command as the input to another command.
#####################################
# >
# Send all success stream data to output
.\dummy.ps1 > script.log

# >>
# Appends all success stream data to output
.\dummy.ps1 >> script.log

# n>&1
# Redirects a specified stream (n) to output
#    3>&1 – is for warning redirection
#    2>&1 – is for error redirection
#
# Stream #	Description	
# 1	        Success Stream
# 2	        Error Stream
# 3	        Warning Stream
# 4	        Verbose Stream
# 5	        Debug Stream
# 6	        Information Stream
# *	        All Streams
.\dummy.ps1 3>&1 script.log


#####################################
# Split and Join Operator
#####################################
# -split
# Splits a string into to substring based on a delimiter
-split "one two three four"

# Splits string with a specified delimiter
"Lastname:FirstName:Address" -split ":"

# -join
# Joins given strings to a single string
-join "a", "b", "c"


#####################################
# Type Operator
#####################################
# -is
# Compares instance of the specified .NET type and return True if equal.	
32 -is "int"
# -isNot
# Compares the instance of specified .NET and return False if not equal.
32 -isNot "int"
# -as	
# Converts the given value to the specified type
"12/31/07" -as [DateTime]


#####################################
# Unary Operator
#####################################
# ++	
# Increments value by 1and assign back
$a = 9
$a++

# -- Decrement value by 1 and assign back
$a = 9
$a--


#####################################
# Special Operator
#####################################
# ----------- @ operator - usage 1: The array sub-expression operator
# The array sub-expression operator creates an array, even if it contains zero or one object.
$b = @()
$b.Count
# ---------- @ operator - usage 2: Hash initializer
$pets = @{Cat = 'Frisky'; Dog = 'Spot'; Fish = 'Nimo'; Hamster = 'Whiskers'}
# ---------- @ operator - usage 3: Splatting 
# Let's you invoke a cmdlet with parameters from an array or a hash-table
# >> SPLATTING WITH HASH TABLES
# the tedious way
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf
# the hash tables way
$HashArguments = @{
    Path = "test.txt";
    Destination = "test2.txt";
    WhatIf = $true;
}
Copy-Item @HashArguments
# >> SPLATTING WITH ARRAYS
# the tedious way
Copy-Item "test.txt" "test2.txt" -WhatIf
# the list way
$ArrayArguments = "test.txt", "test2.txt"
Copy-Item @ArrayArguments -WhatIf
# ---------- @ operator - usage 4: Here strings
# Let's you create strings with easily embedded quotes, typically used for multi-line strings
@(Get-WmiObject win32_logicalDisk)
$data = @"
    line one
  line two
         something "quoted" here
"@
# ---------- @ operator - usage 5: Display the result of one or more statements as a list.
@(Get-Process -Name chrome) # this is now a list
@(Get-Process -Name chrome)[0] # the entry at index 0

# &	
# Runs a command, script or block.
$c = "Get-ExecutionPolicy"
& $c

#[ ] - cast
# Converts object to specified type
[int64]$a = 34
# no cast
$content1 = Get-Content .\sample.xml
$content1.GetType() # an Object
# cast way 1 = more powershell style
[xml]$content2 = Get-Content .\sample.xml
$content2.GetType() # XmlDocument
# cast way 2 - more java style
$content3 =[xml](Get-Content .\sample.xml)
$content3.GetType() # XmlDocument

#,
# Comma creates an array.
$myArray = 1,2,3

# -f
# Format operator, formats string by format methods	
"{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi

# ..
# Generates a range
1..10