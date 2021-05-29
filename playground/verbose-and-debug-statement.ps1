function Welcome-Simple {
    # A simple function doesn't support -Verbose and -Debug
    param (
        [string]$Message
    )
    
    #Verbose - this is only shown if the -Verbose switch is used
    Write-Verbose -Message "This is verbose output"
    
    #Debug - this causes the script to halt at this point
    Write-Debug "This is debugging information"

    Write-Host Welcome $Message -ForegroundColor Green
}


function Welcome-Advanced {
    # An advanced function support -Verbose and -Debug
    [cmdletbinding()] #This provides the function with the -Verbose and -Debug parameters
    param(
        [string]$Message
        )
    
    #Verbose - this is only shown if the -Verbose switch is used
    Write-Verbose -Message "This is verbose output"
    
    #Debug - this causes the script to halt at this point
    Write-Debug "This is debugging information"

    Write-Host Welcome $Message -ForegroundColor Green
}
