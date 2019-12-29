#######################################################################
# Most cmdlets and functions follow the Verb-Noun naming convention
#######################################################################

# echo = Write-Host
echo Hello!
Write-Host The same Hello!

# Each command starts on a new line, or after a semicolon;
echo 'This is the first line'
echo 'This is the second line';


#######################################################################
# Variable declaration
#######################################################################
$aString = "some string"
Write-Host $aString
Write-Host "$aString with evaluation"     # with evaluation, will expand variable
Write-Host '$aString without evaluation'  # without evaluation, will not expand variable

$aNumber = 5 -as [double]
Write-Host "the double number is $aNumber"

$aList = 1, 2, 3, 4, 5
Write-Host "the list is $aList"

$anEmptyList = @{}
Write-Host "the empty list is $anEmptyList"

$anotherString = $aList -join '--'
Write-Host "another string is $anotherString"

$aHashTable = @{name1 = 'val1' ; name2 = 'val2'}
Write-Host "the hash table is $aHashTable"

#######################################################################
# Using variables
#######################################################################
Write-Output $aString
Write-Output "with evaluation: $aString"
Write-Output "$aString has length of $($aString.Length)"
Write-Output '$aString'
Write-Output @"
   This will be displayed
       as
     it     is
    --$aString--
"@ 

#######################################################################
# Built-in variables
#######################################################################
Write-Output "Booleans: $TRUE and $FALSE"
Write-Output "Empty value: $NULL"
Write-Output "Last program's return value: $?"
Write-Output "Exit code of last run Windows-based program: $LastExitCode"
Write-Output  "The last token in the last line received by the session: $$"
Write-Output  "The first token: $^"
Write-Output  "Script's PID: $PID"
Write-Output  "Full path of current script directory: $PSScriptRoot"
Write-Output  'Full path of current script: ' + $MyInvocation.MyCommand.Path
Write-Output  "FUll path of current directory: $Pwd"
Write-Output  "Bound arguments in a function, script or code block: $PSBoundParameters"
Write-Output  "Unbound arguments: $($Args -join ', ')."

# you can find more by `help about_Automatic_Variables`


#######################################################################
# Inline another file with dot operator
#######################################################################
. .\learn\dummy.ps1

