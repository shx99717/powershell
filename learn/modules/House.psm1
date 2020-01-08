# This is a script module that manages houses in a subdivision

$Neighborhood = 'Fancy subdivision'

function New-House {
    Write-Host "Build a new house in $Neighborhood" -ForegroundColor Green -BackgroundColor Black
}

function Get-House {
    Write-Host "Find a house in $Neighborhood" -ForegroundColor Green -BackgroundColor Black
}

function Set-House {
    Write-Host "Modify a house in some way in $Neighborhood" -ForegroundColor Green -BackgroundColor Black
}

function Remove-House {
    Write-Host "Remove a house in $Neighborhood" -ForegroundColor Green -BackgroundColor Black
}


Export-ModuleMember -Function 'Get-*'
Export-ModuleMember -Function 'Set-*'
Export-ModuleMember -Variable 'Neighborhood'


# I've got every function I need to create new houses, find all the houses I've created, modify the houses, 
# and finally, remove houses. The houses I'm managing with this module happen to be in the 'Fancy subdivision' 
# neighborhood, so it's good practice to set that as a module variable at the top. This way, I can reference 
# that variable in any of my functions.
# Because I'm sharing this module with my contractors, I don't want them to build any new houses or remove 
# any houses without my permission, so I'm only allowing them Get-* functions and Set-* functions. I want my 
# contractors to be able to tell what neighborhood we'll be working in, so I allow them to see the value of 
# $Neighborhood in their PowerShell console.

