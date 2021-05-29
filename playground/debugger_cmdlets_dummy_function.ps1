function Test-Cmdlet {
    begin {
        Write-Output "Begin 1 ..."
        Write-Output "Begin 2 ..."
        Write-Output "Begin 3 ..."
    }
    process {
        Write-Output "Process 1 ..."
        Write-Output "Process 2 ..."
        Write-Output "Process 3 ..."
    }
    end {
        Write-Output "End 1 ..."
        Write-Output "End 2 ..."
        Write-Output "End 3 ..."
    }
}