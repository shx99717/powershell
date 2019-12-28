#########################################
# Change ExecutionPolicy
#########################################
Get-ExecutionPolicy -List
Set-ExecutionPolicy AllSigned
# Execution policies include:
# - Restricted: Scripts won't run.
# - RemoteSigned: Downloaded scripts run only if signed by a trusted publisher. 
# - AllSigned: Scripts need to be signed by a trusted publisher.
# - Unrestricted: Run all scripts.

#########################################
# MISC
#########################################
# Current PowerShell version:
$PSVersionTable


#########################################
# How to get help
#########################################
# use wildcard
Get-Command Get-*
# find all Command begin with Add
Get-Command -Verb Add
# command could be invoked by alias
# gcm  is equal to Get-Command
# find the original commands
Get-Alias gcm
# find the alias for the original commands --> gps, ps
Get-Alias -Definition Get-Process
# get the help doc for command
Get-Help Get-Command
# get the member of the result
Get-Process | Get-Member # gps | gm  or Get-Process | gm
# use GUI to fill in the parameters
Show-Command Get-EventLog
# to update the help doc, please run as administrator

# difference between help and Get-Help
# Using help pipe the output through more as you get a page by page display, 
# whereas using Get-Help dumps everything at one go. 
# help is a function
# Get-Help is a cmdlet
# try to invoke Get-Command help, you can find actually help is a function
Get-Command help      # a function
Get-Command Get-Help  # a cmdlet


# powershell has a lot of about pages that describes the language
# e.g. about_Arithmetic_Operators
#      about_Assignment_Operators
#      about_Comparison_Operators
#      about_Automatic_Variables
#      ...
# we can view the about page by
help about_Automatic_Variables
