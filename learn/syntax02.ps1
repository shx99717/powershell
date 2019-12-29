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

--- here The classic for