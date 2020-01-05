### It's all .NET
# A PS string is in fact a .NET System.String
# All .NET methods and properties are thus available
# the .NET way
'this is a string'.ToUpper().Replace('G', 'ggg')
# the powershell way
'This is a string'.ToUpper() -replace 'G', 'ggg'
# find the method to use
'this is a string' | Get-Member


# Syntax for calling static .NET methods
# Note that .NET functions MUST be called with parentheses
# while PS functions CANNOT be called with parentheses.
# If you do call a cmdlet/PS function with parentheses,
# it is the same as passing a single parameter list
# Not all .NET Framework classes can be created by using New-Object
# e.g. System.Environment or System.Math can not be created using New-Object, because
# Classes like these are called static classes

# Usually, the first step in working with an object in Windows PowerShell is to use Get-Member 
# to find out what members it contains. With static classes, the process is a little different
# because the actual class is not an object, therefore we can not call Get-Member like
# System.Environment | Get-Member
# instead, by referring to the static class
[System.Environment] | Get-Member
# Windows PowerShell automatically prepends 'System.' to type names, therefore we can omit the System
[Environment] | Get-Member
# to view the static members
[Environment] | Get-Member -Static
# The properties of System.Environment are also static, and must be specified in a different way than normal properties. 
# We use :: to indicate to Windows PowerShell that we want to work with a static method or property. 
[System.Environment]::CommandLine
[System.Environment]::OSVersion
[System.Math] | Get-Member -Static -MemberType Methods
[System.Math]::Sqrt(9)
[System.Math]::Pow(2,3)
[System.Math]::Ceiling(-3.3)


# creating .NET object
# e.g.
New-Object -TypeName System.Version -ArgumentList "1.2.3.4"
# e.g.
$array = @('One', 'Two', 'Three')
$parameters = @{
    TypeName = 'System.Collections.Generic.HashSet[string]'
    ArgumentList = ([string[]]$array, [System.StringComparer]::OrdinalIgnoreCase)
}
$set = New-Object @parameters
$set | Get-Member
# e.g.
$countries = New-Object System.Collections.ArrayList
$countries.Add("China")
$countries.Add("USA")
$countries.Add("India")
$countries | % { $_ }


# Read input
# Reading a value from input:
$Name = Read-Host "What's your name?"
Write-Output "Hello, $Name!"
[int]$Age = Read-Host "What's your age?"
Write-Output "Age at $Age"


# Path related cmdlet
# ----- Test-Path
# Determines whether all elements of a path exist.
Test-Path -Path "C:\Documents and Settings\" # True
Test-Path -Path "C:\Documents_and_Settings\" # False

# ----- Split-Path
# Returns the specified part of a path.
# Get the qualifier of the path
Split-Path -Path "HKCU:\Software\Microsoft" -Qualifier
# Display file names
Split-Path -Path "C:\Windows\*.exe" -Leaf -Resolve
# Get the parent container
Split-Path -Path "C:\WINDOWS\system32\"
# Change location to a specified path
Set-Location (Split-Path -Path $profile)

# ----- Join-Path
# Combines a path and a child path into a single path.
# Combine a path with a child path
Join-Path -Path "path" -ChildPath "childpath"
# Combine paths that already contain directory separators
Join-Path -Path "path\" -ChildPath "\childpath"
# Display files and folders by joining a path with a child path
Join-Path "C:\win*" "System*" -Resolve
# Combine multiple path roots with a child path
Join-Path -Path C:, D: -ChildPath New
# Join multiple path
Join-Path "C:" -ChildPath "Windows" | Join-Path -ChildPath "system32" | Join-Path -ChildPath "drivers"
# or with .NET
[IO.Path]::Combine('C:\', 'Windows', 'system32','drivers')

# ----- Resolve-Path
# Resolves the wildcard characters in a path, and displays the path contents.
# Resolve the home folder path
Resolve-Path ~
# Get all paths in the Windows folder
"C:\windows\*" | Resolve-Path
# Resolve a UNC path
Resolve-Path -Path "\\Server01\public"
# Get relative paths
Resolve-Path -Path "c:\prog*" -Relative


# content related cmdlet
# Get the content of a text file
1..100 | ForEach-Object { Add-Content -Path .\LineNumbers.txt -Value "This is line $_." }
Get-Content -Path .\LineNumbers.txt # returns an string[]
# Limit the number of lines Get-Content returns
Get-Content -Path .\LineNumbers.txt -TotalCount 5
# Get the last line of a text file
Get-Content -Path .\LineNumbers.txt -Tail 1
# Get raw content, in one string rather than string[]
$raw = Get-Content -Path .\LineNumbers.txt -Raw
$lines = Get-Content -Path .\LineNumbers.txt
Write-Host "Raw contains $($raw.Count) lines."
Write-Host "Lines contains $($lines.Count) lines."
# Use Filters with Get-Content
# The following command gets the content of all *.xml files in the C:\Windows\ directory.
Get-Content -Path "C:\Windows\*" -Filter *.xml
# Replace the contents of multiple files in a directory
Get-ChildItem -Path .\Test*.txt
Set-Content -Path .\Test*.txt -Value 'Hello, World'
Get-Content -Path .\Test*.txt
# Create a new file and write content
Set-Content -Path .\DateTime.txt -Value (Get-Date)
Get-Content -Path .\DateTime.txt
# Replace text in a file
Get-Content -Path .\Notice.txt
(Get-Content -Path .\Notice.txt) |
    ForEach-Object {$_ -Replace 'Warning', 'Caution'} |
        Set-Content -Path .\Notice.txt
Get-Content -Path .\Notice.txt
# Use Filters with Set-Content
# The following command set the content all *.txt files in the z:\tmp directory to the value 'hello'
Set-Content -Path "Z:\tmp" -Filter *.txt -Value "hello"
# Add a string to all text files with an exception
Add-Content -Path .\Test*.txt -Exclude help* -Value 'End of file'
# Add a date to the end of the specified files
# The PassThru parameter outputs the added contents to the pipeline. Because there is no other cmdlet 
# to receive the output, it is displayed in the PowerShell console. 
Add-Content -Path .\Test*.txt -Exclude help* -Value (Get-Date) -PassThru
# Add the contents of a specified file to another file
$From = Get-Content -Path .\CopyFromFile.txt
Add-Content -Path .\CopyToFile.txt -Value $From
Get-Content -Path .\CopyToFile.txt
# Add the contents of a specified file to another file using the pipeline
Get-Content -Path .\CopyFromFile.txt | Add-Content -Path .\CopyToFile.txt
Get-Content -Path .\CopyToFile.txt
# Delete all content from those files, but does not delete the items
Clear-Content -Path ".\Test*.txt"
# Delete content of all files with a wildcard
# The Force parameter makes the command effective on read-only files
Clear-Content -Path "z:\*" -Filter "*.log" -Force



