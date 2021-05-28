$person = "developer"

if ($person -eq "developer") {
    Write-Host "Hi Developer, start coding now..."

} elseif ($person -eq "productowner") {
    Write-Host "Hi Product Owner, start coding now..."

} else {
    Write-Host "Follow the white rabbi..."
}

Write-Host "Last line in file!"


function Say-HelloWorld { 
    Write-Host 'Hello World!' 
}