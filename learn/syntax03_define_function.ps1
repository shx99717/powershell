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
# A filter is a type of function that runs on each object in the pipeline. 
# A filter resembles a function with all its statements in a Process block.
# (A filter is function that just has a process scriptblock)
# the syntax:
# filter [<scope:>]<name> {<statement list>}
filter isEven {
    if($_ % 2 -eq 0) { $_ }
}

filter greaterThan([int]$number) {
    if($_ -gt $number) { $_ }
}

filter isOdd([switch]$beautify) {
    if($_ % 2 -ne 0) {
        if($beautify) {
            "((($_)))"
        } else {
            $_
        }
    }
}
1..10 | isEven
1..10 | greaterThan 3
1..10 | isOdd
1..10 | isOdd -beautify


# <<<<<Function Scope>>>>>
# - global
# - local
# - private
# - script
# - using
# - workflow
# - <variable-namespace>, Alias:, Env:, Function:, Variable:
# The default scope for scripts is the script scope. 
# The default scope for functions and aliases is the local scope, even if they are defined in a script.
# A function exists in the scope in which it was created.
# If a function is part of a script, the function is available to statements within that script. 
# By default, a function in a script is not available at the command prompt.

# specify scope for variable, the syntax:
# $[<scope-modifier>:]<name> = <value>
$a = 'one' # local scope
$Global:a = 'global one' # global scope


# specify scope for function, the syntax:
# function [<scope-modifier>:]<name> {<function-body>}
# You can specify the scope of a function. For example, the function is added to the global scope in the
# following example:
function global:Get-Something {
}
# When a function is in the global scope, you can use the function in scripts, in functions, and at
# the command line.
# Functions normally create a scope. The items created in a function, such as variables, exist only in
# the function scope.


# <<<<<Finding and Managing Functions Using the Function: Drive>>>>>
# All the functions and filters in PowerShell are automatically stored in the Function: drive. This drive is exposed by the PowerShell Function provider.
Get-ChildItem function: # same as ls function:

function sayHello([string]$name) {
    Write-Host "Hello world, $name"
}
# View the definition of a function
(Get-ChildItem Function:\sayHello).Definition
# or
$function:sayHello
# similar we can get all environmental variables by:
Get-ChildItem Env:




#########################################################
# Advanced functions
#########################################################
# an advanced function that acts similar to cmdlets
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


# The following example shows a function that accepts a name and then prints a greeting 
# using the supplied name. Also notice that this function defines a name that includes a 
# verb (Send) and noun (Greeting) pair similar to the verb-noun pair of a compiled cmdlet. 
function Send-Greeting {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string] $Name        
    )
   
    process {
        Write-Host "Hello $Name!"
    }
    
}

# The parameters of the function are declared by using the Parameter attribute. This 
# attribute can be used alone, or it can be combined with the Alias attribute or with
# several other parameter validation attributes. 

# You can add parameters to the advanced functions that you write, and use parameter 
# attributes and arguments to limit the parameter values that function users submit with 
# the parameter.

# for details about common parameters, please visit 
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters
# The parameters that you add to your function are available to users in addition to the 
# common parameters that PowerShell adds automatically to all cmdlets and advanced functions. 
# common parameters can be used for any cmdlet and advanced function.
# how to make common parameters available to an advanced function, is by
# - using CmdletBinding attribute
# - using Parameter attribute

# The following list displays the common parameters. Their aliases are listed in parentheses.
# - Debug (db)
# - ErrorAction (ea)
# - ErrorVariable (ev)
# - InformationAction (infa)
# - InformationVariable (iv)
# - OutVariable (ov)
# - OutBuffer (ob)
# - PipelineVariable (pv)
# - Verbose (vb)
# - WarningAction (wa)
# - WarningVariable (wv)

# The Action parameters are ActionPreference type values. ActionPreference is an enumeration 
# with the following values:
# Name	                Value
# Suspend	            5
# Ignore	            4
# Inquire	            3
# Continue	            2
# Stop	                1
# SilentlyContinue      0
# You may use the name or the value with the parameter.


# In addition to the common parameters, many cmdlets offer risk mitigation parameters. 
# Cmdlets that involve risk to the system or to user data usually offer these parameters.
# The risk mitigation parameters are:
# - WhatIf (wi)
# - Confirm (cf)



# <<<<<Static parameters>>>>>
# Static parameters are parameters that are always available in the function. Most parameters in
# PowerShell cmdlets and scripts are static parameters.
# The following example shows the declaration of a ComputerName parameter that has the following characteristics:
# - It's mandatory (required).
# - It takes input from the pipeline.
# - It takes an array of strings as input.
# Param(
#     [Parameter(Mandatory=$true,
#     ValueFromPipeline=$true)]
#     [String[]]
#     $ComputerName
# )

# The Parameter attribute is optional, and you can omit it if none of the parameters of your functions need attributes. 
# But, to be recognized as an advanced function, rather than a simple function, a function must have either the CmdletBinding 
# attribute or the Parameter attribute, or both.

# <<<<<Parameter attribute>>>>>
# syntax:
# Param(
#     [Parameter(Argument1=value1, Argument2=value2)]
#     $ParameterName
# )

# Mandatory argument
# The Mandatory argument indicates that the parameter is required. If this argument isn't specified, the parameter is optional.
# Param(
#     [Parameter(Mandatory=$true)]
#     [String[]]
#     $ComputerName
# )


# Position argument
# The Position argument determines whether the parameter name is required when the parameter is used in a command. When a parameter 
# declaration includes the Position argument, the parameter name can be omitted and PowerShell identifies the unnamed parameter value 
# by its position, or order, in the list of unnamed parameter values in the command.
# By default, all function parameters are positional. PowerShell assigns position numbers to parameters in the order in which the 
# parameters are declared in the function. To disable this feature, set the value of the PositionalBinding argument of the 
# CmdletBinding attribute to $False.
# The following example declares the ComputerName parameter. It uses the Position argument with a value of 0. As a result, when -ComputerName
# is omitted from command, its value must be the first or only unnamed parameter value in the command.
# Param(
#     [Parameter(Position=0)]
#     [String[]]
#     $ComputerName
# )


# ValueFromPipeline argument
# The ValueFromPipeline argument indicates that the parameter accepts input from a pipeline object. Specify this argument if the function 
# accepts the entire object, not just a property of the object.
# Param(
#     [Parameter(Mandatory=$true,
#     ValueFromPipeline=$true)]
#     [String[]]
#     $ComputerName
# )


# ValueFromPipelineByPropertyName argument
# The ValueFromPipelineByPropertyName argument indicates that the parameter accepts input from a property of a pipeline object. The object 
# property must have the same name or alias as the parameter.

# For example, if the function has a ComputerName parameter, and the piped object has a ComputerName property, the value of the ComputerName 
# property is assigned to the function's ComputerName parameter.

# The following example declares a ComputerName parameter that's mandatory and accepts input from the object's ComputerName property 
# that's passed to the function through the pipeline.
# Param(
#     [Parameter(Mandatory=$true,
#     ValueFromPipelineByPropertyName=$true)]
#     [String[]]
#     $ComputerName
# )


# ValueFromRemainingArguments argument
# The ValueFromRemainingArguments argument indicates that the parameter accepts all the parameter's values in the command that aren't 
# assigned to other parameters of the function.

# The following example declares a Value parameter that's mandatory and a Remaining parameter that accepts all the remaining parameter 
# values that are submitted to the function.

function Test-Remaining
{
     param(
         [string]
         [Parameter(Mandatory = $true, Position=0)]
         $Value,
         [string[]]
         [Parameter(Position=1, ValueFromRemainingArguments)]
         $Remaining)
     "Found $($Remaining.Count) elements"
     for ($i = 0; $i -lt $Remaining.Count; $i++)
     {
        "${i}: $($Remaining[$i])"
     }
}

Test-Remaining one two three four


# HelpMessage argument
# The HelpMessage argument specifies a string that contains a brief description of the parameter or its value. PowerShell displays 
# this message in the prompt that appears when a mandatory parameter value is missing from a command. This argument has no effect on 
# optional parameters.
# # The following example declares a mandatory ComputerName parameter and a help message that explains the expected parameter value.
# Param(
#     [Parameter(Mandatory=$true,
#     HelpMessage="Enter one or more computer names separated by commas.")]
#     [String[]]
#     $ComputerName
# )


# Alias attribute
# The Alias attribute establishes an alternate name for the parameter. There's no limit to the number of aliases that you can 
# assign to a parameter.
# The following example shows a parameter declaration that adds the CN and MachineName aliases to the mandatory ComputerName parameter.
# Param(
#     [Parameter(Mandatory=$true)]
#     [Alias("CN","MachineName")]
#     [String[]]
#     $ComputerName
# )



# Parameter and variable validation attributes
# Validation attributes direct PowerShell to test the parameter values that users submit when they call the advanced function. 
# If the parameter values fail the test, an error is generated and the function isn't called. You can also use some of the 
# validation attributes to restrict the values that users can specify for variables.
# ----- AllowNull validation attribute, The AllowNull attribute allows the value of a mandatory parameter to be $null. 
# The following example declares a ComputerName parameter that can have a null value.
# Param(
#     [Parameter(Mandatory=$true)]
#     [AllowNull()]
#     [String]
#     $ComputerName
# )
# ----- AllowEmptyString validation attribute
# The AllowEmptyString attribute allows the value of a mandatory parameter to be an empty string (""). The following example 
# declares a ComputerName parameter that can have an empty string value.
# Param(
#     [Parameter(Mandatory=$true)]
#     [AllowEmptyString()]
#     [String]
#     $ComputerName
# )
# ----- AllowEmptyCollection validation attribute
# The AllowEmptyCollection attribute allows the value of a mandatory parameter to be an empty collection @(). The following 
# example declares a ComputerName parameter that can have an empty collection value.
# Param(
#     [Parameter(Mandatory=$true)]
#     [AllowEmptyCollection()]
#     [String[]]
#     $ComputerName
# )
# ----- ValidateCount validation attribute
# The ValidateCount attribute specifies the minimum and maximum number of parameter values that a parameter accepts. 
# PowerShell generates an error if the number of parameter values in the command that calls the function is outside that range.
# The following parameter declaration creates a ComputerName parameter that takes one to five parameter values.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateCount(1,5)]
#     [String[]]
#     $ComputerName
# )
# ----- ValidateLength validation attribute
# The ValidateLength attribute specifies the minimum and maximum number of characters in a parameter or variable value. 
# PowerShell generates an error if the length of a value specified for a parameter or a variable is outside of the range.
# In the following example, each computer name must have one to ten characters.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateLength(1,10)]
#     [String[]]
#     $ComputerName
# )
# In the following example, the value of the variable $number must be a minimum of one character in length, and a maximum of ten characters
# [Int32][ValidateLength(1,10)]$number
# ----- ValidatePattern validation attribute
# The ValidatePattern attribute specifies a regular expression that's compared to the parameter or variable value. 
# PowerShell generates an error if the value doesn't match the regular expression pattern.
# In the following example, the parameter value must contain a four-digit number, and each digit must be a number zero to nine.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidatePattern("[0-9][0-9][0-9][0-9]")]
#     [String[]]
#     $ComputerName
# )
# In the following example, the value of the variable $number must be exactly a four-digit number, and each digit must be a number zero to nine
# [Int32][ValidatePattern("^[0-9][0-9][0-9][0-9]$")]$number
# ----- ValidateRange validation attribute
# The ValidateRange attribute specifies a numeric range or a ValidateRangeKind enum value for each parameter or variable value. 
# PowerShell generates an error if any value is outside that range.
# The ValidateRangeKind enum allows for the following values:
# - Positive - A number greater than zero.
# - Negative - A number less than zero.
# - NonPositive - A number less than or equal to zero.
# - NonNegative - A number greater than or equal to zero.
# In the following example, the value of the Attempts parameter must be between zero and ten.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateRange(0,10)]
#     [Int]
#     $Attempts
# )
# In the following example, the value of the variable $number must be greater than zero.
# [Int32][ValidateRange("Positive")]$number
# ----- ValidateScript validation attribute
# The ValidateScript attribute specifies a script that is used to validate a parameter or variable value. PowerShell pipes the 
# value to the script, and generates an error if the script returns $false or if the script throws an exception.
# When you use the ValidateScript attribute, the value that's being validated is mapped to the $_ variable. You can use the $_ variable 
# to refer to the value in the script.
# In the following example, the value of the EventDate parameter must be greater than or equal to the current date.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateScript({$_ -ge (Get-Date)})]
#     [DateTime]
#     $EventDate
# )
# ----- ValidateSet attribute
# The ValidateSet attribute specifies a set of valid values for a parameter or variable and enables tab completion. PowerShell generates 
# an error if a parameter or variable value doesn't match a value in the set. In the following example, the value of the Detail 
# parameter can only be Low, Average, or High.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateSet("Low", "Average", "High")]
#     [String[]]
#     $Detail
# )
# In the following example, the value of the variable $flavor must be either Chocolate, Strawberry, or Vanilla.
# [ValidateSet("Chocolate", "Strawberry", "Vanilla")]
# [String]$flavor
# ----- ValidateNotNull validation attribute
# The ValidateNotNull attribute specifies that the parameter value can't be $null. PowerShell generates an error if the parameter value 
# is $null.
# The ValidateNotNull attribute is designed to be used when the type of the parameter value isn't specified or when the specified 
# type accepts a value of $null. If you specify a type that doesn't accept a $null value, such as a string, the $null value is 
# rejected without the ValidateNotNull attribute, because it doesn't match the specified type.
# In the following example, the value of the ID parameter can't be $null.
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateNotNull()]
#     $ID
# )
# ----- ValidateNotNullOrEmpty validation attribute
# The ValidateNotNullOrEmpty attribute specifies that the parameter value can't be $null and can't be an empty string (""). 
# PowerShell generates an error if the parameter is used in a function call, its value is $null, an empty string (""), or 
# an empty array @().
# Param(
#     [Parameter(Mandatory=$true)]
#     [ValidateNotNullOrEmpty()]
#     [String[]]
#     $UserName
# )
# ----- ValidateDrive validation attribute
# The ValidateDrive attribute specifies that the parameter value must represent the path, that's referring to allowed drives only. 
# PowerShell generates an error if the parameter value refers to drives other than the allowed. Existence of the path, except for 
# the drive itself, isn't verified.
# If you use relative path, the current drive must be in the allowed drive list.
# Param(
#     [ValidateDrive("C", "D", "Variable", "Function")]
#     [String]$Path
# )
# ----- ValidateUserDrive validation attribute
# The ValidateUserDrive attribute specifies that the parameter value must represent the path, that is referring to User drive. 
# PowerShell generates an error if the path refers to other drives. Existence of the path, except for the drive itself, isn't verified.
# If you use relative path, the current drive must be User.
# You can define User drive in Just Enough Administration (JEA) session configurations.
# Param(
#     [ValidateUserDrive()]
#     [String]$Path
# )


# Switch parameter
# Switch parameters are parameters with no parameter value
# Param([Switch]$IncludeAll)


# ArgumentCompleter attribute (for parameter value tab completion)
# The ArgumentCompleter attribute allows you to add tab completion values to a specific parameter. An ArgumentCompleter attribute must be
# defined for each parameter that needs tab completion.
# the available values are calculated at runtime when the user presses Tab after the parameter name.
# A fairly commonly-requested functionality for custom functions is to be able to perform custom tab completion.
# way 1: In simple scenarios, this can be accomplished with [ValidateSet()], which takes an array of values that it will cycle through for tab completion. Enums can also be used for this functionality.
# way 2: Another, more advanced option is Register-ArgumentCompleter. However, this has the distinct disadvantage that it must be invoked from outside the function after the function has been parsed and read into memory.
# way 3: There's a third option that we don't really see mentioned much: [ArgumentCompleter()]
function Test-ArgumentCompleter {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [ArgumentCompleter({ Get-ChildItem -Path 'C:\' -Directory | Select-Object -ExpandProperty Name })]
        [ValidateScript({$_ -in (Get-ChildItem -Path 'C:\' -Directory | Select-Object -ExpandProperty Name) })]
        [string]
        $FolderName
    )
    Write-Warning "You have selected the folder $FolderName"
    Remove-Item "C:\$FolderName" -WhatIf
}

