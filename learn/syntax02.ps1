#########################################################
# control flow
#########################################################

# if elseif else
$age = 18
if($age -is [string]) {
    Write-Output '$age should not be a string!'
} elseif ($age -lt 12 -and $age -gt 0) {
    Write-Output 'Child age less than 12 and greater than 0' 
} else {
    Write-Output 'Adult'
}



# Switch statements are more powerful compared to most languages
$val = "20"
switch($val) {
  { $_ -eq 42 }           { "The answer equals 42"; break }
  '20'                    { "Exactly 20"; break }
  { $_ -like 's*' }       { "Case insensitive"; break }
  { $_ -clike 's*'}       { "clike, ceq, cne for case sensitive"; break }
  { $_ -notmatch '^.*$'}  { "Regex matching. cnotmatch, cnotlike, ..."; break }
  { 'x' -contains 'x'}    { "FALSE! -contains is for lists!"; break }
  default                 { "Others" }
}


# The classic for
for($i = 1; $i -le 10; $i++) {
    "Loop number $i"
}

# or shorter
1 .. 10 | % { "Loop number $_" }

# foreach
foreach ($var in 'var1', 'var2', 'var3') {
    Write-Output $var
}
# same as above
foreach ($var in @('var1', 'var2', 'var3')) {
    Write-Output $var
}

# while
$index = 0
while ($index -lt 20) {
    Write-Output "hello world index = $index"
    $index++;
}

# do while
$index = 0
do {
    Write-Output "hello world index = $index"
    $index++;
} while ($index -lt 20)

# do block will be execute until (the condition become true)
$index = 0
do {
    Write-Output "hello world index = $index"
    $index++;
} until ($index -gt 20)


# Exception handling
try {

} catch {

} finally {

}


try {

} catch [System.NullReferenceException] {
    Write-Output $_.Exception | Format-List -Force
}



#########################################################
# Get all providers
#########################################################
Get-PSProvider
# Name                 Capabilities                                                                            Drives
# ----                 ------------                                                                            ------
# Registry             ShouldProcess, Transactions                                                             {HKLM, HKCU}
# Alias                ShouldProcess                                                                           {Alias}
# Environment          ShouldProcess                                                                           {Env}
# FileSystem           Filter, ShouldProcess, Credentials                                                      {C, E, F, G...}
# Function             ShouldProcess                                                                           {Function}
# Variable             ShouldProcess                                                                           {Variable}
# Certificate          ShouldProcess                                                                           {Cert}
# WSMan                Credentials                                                                             {WSMan}



#########################################################
# Pipeline
#########################################################
# Results of the previous cmdlet can be passed to the next as input.
# `$_` is the current object in the pipeline object.
# { ... } is the script block
Get-ChildItem | Where-Object { $_.Name -match 'l' } | Export-Csv export.txt
# ls = Get-ChildItem
# ?  = Where-Object
ls | ? { $_.Name -match 'l' } | ConvertTo-HTML | Out-File export.html


# ` is the line continuation character. Or end the line with a |
Get-Process | Sort-Object ID -Descending | Select-Object -First 10 Name,Id,VM `
| Stop-Process -WhatIf


# Use % as a shorthand for ForEach-Object
@(3,4,5) | ForEach-Object `
    -Begin { "Starting"; $counter = 0 } `
    -Process { "Processing $_"; $counter++ } `
    -End { "Finishing: $counter" }

@(3,4,5) | % `
    -Begin { "Starting"; $counter = 0 } `
    -Process { "Processing $_"; $counter++ } `
    -End { "Finishing: $counter" }

# Get-Process as a table with three columns
# The third column is the value of the VM property in MB and 2 decimal places
# Computed columns can be written more verbose as:
# `@{name='lbl';expression={$_}`
Get-Process | Format-Table Id, Name, @{name='VM(MB)'; expression={'{0:n2}' -f ($_.VM / 1MB)}} -AutoSize

-- go check basic01.ps1, line 19 and learn x in y --> Functions