#########################################################
# Difference between
# - cmdlet 
#   A cmdlet is a .NET class written in C# or other .NET language and contained in a .dll 
#   (i.e. in a binary module).     
# 
# - simple function
#   * is appropriate for scripting and module-internal helper functions
#   * requires less syntax (simpler syntax without parameter attributes, single-script-block body)
#   * the name of the simple function does not have to follow the Verb-Noun pattern
#     You can assign any name to a function, but functions that you share with others should follow the naming rules that have been established for all PowerShell commands.
#     Functions names should consist of a verb-noun pair in which the verb identifies the action that the function performs and the noun identifies the item on which the cmdlet performs its action.
#
# - advanced function
#   An advanced function is the written-in-PowerShell analog of a cmdlet, the magic is the CmdletBinding()
#   attribute, it supports certain standard behaviors, like:
#   * You gain automatic support for common parameters such as -Verbose, and -OutVariable and, if the function is implemented accordingly, for -WhatIf and -Confirm.
#   * Arguments not bound to explicitly declared parameters result in an error on invocation.
#   * best practice to name it as Verb-Noun convention


# A module manifest may export cmdlets and functions
# Remark: while exporting functions as part of a module(*.psd1), although
# it does not enforce that function to be an advanced one, but it is good
# practice to only export advanced function, the simple function should be used
# internally as kind of helper function



#########################################################
# Simple functions
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions
#########################################################
# The syntax
# 
# function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]
# {
#   param([type]$parameter1 [,[type]$parameter2])
#   dynamicparam {<statement list>}
#   begin {<statement list>}
#   process {<statement list>}
#   end {<statement list>}
# }

# A function includes the following items:
# - A Function keyword
# - A scope (optional)
# - A name that you select
# - Any number of named parameters (optional)
# - One or more PowerShell commands enclosed in braces {}

# <<<<< functions with parameters >>>>>
# way 1(preferred): You can define parameters inside the braces using the Param keyword, as shown in the following sample syntax:
# function <name> {
#     param ([type]$parameter1[,[type]$parameter2])
#     <statement list>
# }

# way 2: You can also define parameters outside the braces without the Param keyword, as shown in the following sample syntax:
# function <name> [([type]$parameter1[,[type]$parameter2])] {
#     <statement list>
# }

# e.g. The following example is a function called Get-SmallFiles. This function has a $Size parameter. The function displays all the files that are smaller than the value of the $Size parameter, and it excludes directories:
function Get-SmallFiles {
  Param($Size)
  Get-ChildItem $HOME | Where-Object {
    $_.Length -lt $Size -and !$_.PSIsContainer
  }
}

# call way 1(preferred):
Get-SmallFiles -Size 50
# call way 2:
Get-SmallFiles 50

# we could assign default value
function Get-SmallFiles2 {
    Param($Size = 50)
    Get-ChildItem $HOME | Where-Object {
      $_.Length -lt $Size -and !$_.PSIsContainer
    }
}
# call with default value
Get-SmallFiles2


# <<<<< Positional parameters >>>>>
# A positional parameter is a parameter without a parameter name. PowerShell uses the parameter value order to associate each parameter value with a parameter in the function.
# When you use positional parameters, type one or more values after the function name.
# Positional parameter values are assigned to the $args array variable. The value that follows the 
# function name is assigned to the first position in the $args array, $args[0].

# e.g. The following Get-Extension function adds the .txt file name extension to a file name that you supply:
function Get-Extension {
    $name = $args[0] + ".txt"
    $name
}
Get-Extension hello


# <<<<<Switch Parameters>>>>>
# A switch is a parameter that does not require a value. Instead, you type the function name followed by the name of the switch parameter.
# To define a switch parameter, specify the type [switch] before the parameter name, as shown in the following example:
function Switch-Item {
    param ([switch]$on)
    if ($on) { "Switch on" }
    else { "Switch off" }
}

Switch-Item             # same as Switch-Item -on:$false
Switch-Item -on         # Switch-Item -on:$true


# <<<<<Using Splatting to Represent Command Parameters>>>>>
# Use this technique in functions that call commands in the session. You do not need to declare or 
# enumerate the command parameters, or change the function when command parameters change.
# e.g. The following sample function calls the Get-Command cmdlet. The command uses @Args to represent the parameters of Get-Command.
# The @Args feature uses the $Args automatic parameter, which represents undeclared cmdlet parameters and values from remaining arguments.
function Get-MyCommand { Get-Command @Args }
Get-MyCommand -Name Get-ChildItem

# <<<<<Piping Objects to Functions>>>>>
# Any function can take input from the pipeline. You can control how a function processes input from
# the pipeline using Begin, Process, and End keywords. The following sample syntax shows the three
# keywords:
# function <name> {
#     begin {<statement list>}
#     process {<statement list>}
#     end {<statement list>}
# }
# If your function defines a Begin, Process or End block, all of your code must reside inside one of the blocks.

# [begin] The Begin statement list runs one time only, at the beginning of the function.
# [process] The Process statement list runs one time for each object in the pipeline. While the Process block is running, each pipeline object is assigned to the $_ automatic variable, one pipeline object at a time.
# [end] After the function receives all the objects in the pipeline, the End statement list runs one time. If no Begin, Process, or End keywords are used, all the statements are treated like an End statement list.

function Get-Pipeline {
  begin { "calling begin ..." }
  process { "calling process ... the value is: $_" }
  end { "calling end ..." }
}

1,2,4 | Get-Pipeline



# <<<<<Filters>>>>>
# 

#########################################################
# Advanced functions
#########################################################
# an advanced function
# with named parameters, parameter attributes and parsable documentation
<#
.SYNOPSIS
Setup a new website
.DESCRIPTION
Creates everything your new website needs for much win
.PARAMETER siteName
The name for the new website
.EXAMPLE
New-Website -Name FancySite -Po 5000
New-Website SiteWithDefaultPort
New-Website siteName 2000 # ERROR! Port argument could not be validated
('name1','name2') | New-Website -Verbose
#>
function New-Website() {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [Alias('name')]
        [string]$siteName,
        [ValidateSet(3000,5000,8000)]
        [int]$port = 3000
    )
    BEGIN { 
        Write-Verbose 'Creating new website(s)' 
    }
    PROCESS {
         Write-Output "name: $siteName, port: $port" 
    }
    END { 
        Write-Verbose 'Website(s) created' 
    }
}