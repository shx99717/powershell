# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help


# <<<<<SYNTAX FOR COMMENT-BASED HELP IN FUNCTIONS>>>>>>
# Comment-based help for a function can appear in one of three locations:
# - style 1, At the beginning of the function body.
# - style 2, At the end of the function body.
# - style 3, Before the Function keyword. There cannot be more than one blank line between the last line of the function help and the Function keyword.

# style 1
function Get-Function1
{
<#
.<help keyword>
<help content>
#>

  # function logic
}

# style 2
function Get-Function2
{
   # function logic

<#
.<help keyword>
<help content>
#>
}

# style 3
<#
.<help keyword>
<help content>
#>
function Get-Function3 { }


# <<<<<SYNTAX FOR COMMENT-BASED HELP IN SCRIPTS>>>>>
# Comment-based help for a script can appear in one of the following two locations in the script.
# - style 1, At the beginning of the script file. Script help can be preceded in the script only by comments and blank lines.
#   If the first item in the script body (after the help) is a function declaration, there must be at least two blank lines between the end of the script help and the function declaration. Otherwise, the help is interpreted as being help for the function, not help for the script.
# - style 2, At the end of the script file. However, if the script is signed, place Comment-based help at the beginning of the script file. The end of the script is occupied by the signature block.

# style 1
<#
.<help keyword>
<help content>
#>


function Get-Function { }


# style 2
function Get-Function { }

<#
.<help keyword>
<help content>
#>



# <<<<<SYNTAX FOR COMMENT-BASED HELP IN SCRIPT MODULES>>>>>
# In a script module .psm1, comment-based help uses the syntax for functions, not the syntax for scripts. You cannot use the script syntax to provide help for all functions defined 
# in a script module.




# <<<<<COMMENT-BASED HELP KEYWORDS>>>>>
# The following are valid comment-based help keywords. They are listed in the order in which they typically appear in a help topic along with their intended use. These keywords can appear in any order
# in the comment-based help, and they are not case-sensitive.

# .SYNOPSIS
# A brief description of the function or script. This keyword can be used only once in each topic.

# .DESCRIPTION
# A detailed description of the function or script. This keyword can be used only once in each topic.

# .PARAMETER
# The description of a parameter. Add a ".PARAMETER" keyword for each parameter in the function or script syntax.

# .EXAMPLE
# A sample command that uses the function or script, optionally followed by sample output and a description. Repeat this keyword for each example.

# .INPUTS
# The Microsoft .NET Framework types of objects that can be piped to the function or script. You can also include a description of the input objects.

# .OUTPUTS
# The .NET Framework type of the objects that the cmdlet returns. You can also include a description of the returned objects.

# .NOTES
# Additional information about the function or script.

# .LINK
# The name of a related topic. The value appears on the line below the ".LINK" keyword and must be preceded by a comment symbol # or included in the comment block.

# .COMPONENT
# The technology or feature that the function or script uses, or to which it is related. This content appears when the Get-Help command includes the Component parameter of Get-Help.

# .ROLE
# The user role for the help topic. This content appears when the Get-Help command includes the Role parameter of Get-Help.

# .FUNCTIONALITY
# The intended use of the function. This content appears when the Get-Help command includes the Functionality parameter of Get-Help.

# .FORWARDHELPTARGETNAME
# Redirects to the help topic for the specified command. You can redirect users to any help topic, including help topics for a function, script, cmdlet, or provider.
# .FORWARDHELPTARGETNAME <Command-Name>

# .FORWARDHELPCATEGORY
# Specifies the help category of the item in "ForwardHelpTargetName". Valid values are "Alias", "Cmdlet", "HelpFile", "Function", "Provider", "General", "FAQ", "Glossary", "ScriptCommand", "ExternalScript", "Filter", or "All". Use this keyword to avoid conflicts when there are commands with the same name.
# .FORWARDHELPCATEGORY <Category>

# .REMOTEHELPRUNSPACE
# Specifies a session that contains the help topic. Enter a variable that contains a "PSSession". This keyword is used by the Export-PSSession cmdlet to find the help topics for the exported commands.
# .REMOTEHELPRUNSPACE <PSSession-variable>

# .EXTERNALHELP
# Specifies an XML-based help file for the script or function.
# .EXTERNALHELP <XML Help File>



# <<<<<a good template>>>>>
function Add-Extension
{
param ([string]$Name,[string]$Extension = "txt")
$name = $name + "." + $extension
$name

<#
.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.

.PARAMETER Name
Specifies the file name.

.PARAMETER Extension
Specifies the extension. "Txt" is the default.

.INPUTS

None. You cannot pipe objects to Add-Extension.

.OUTPUTS

System.String. Add-Extension returns a string with the extension
or file name.

.EXAMPLE

PS> extension -name "File"
File.txt

.EXAMPLE

PS> extension -name "File" -extension "doc"
File.doc

.EXAMPLE

PS> extension "File" "doc"
File.doc

.LINK

http://www.fabrikam.com/extension.html

.LINK

Set-Item
#>
}


Get-Help -Name Add-Extension
Get-Help -Name Add-Extension -Full




# <<<<<Parameter Descriptions in Function Syntax>>>>>
# This example is the same as the previous one, except that the parameter descriptions are inserted in the function syntax. This format is most useful when the descriptions are brief.
function Add-Extension2
{
param
(

[string]
#Specifies the file name.
$name,

[string]
#Specifies the file name extension. "Txt" is the default.
$extension = "txt"
)

$name = $name + "." + $extension
$name

<#
.SYNOPSIS

Adds a file name extension to a supplied name.

.DESCRIPTION

Adds a file name extension to a supplied name. Takes any strings for the
file name or extension.

.INPUTS

None. You cannot pipe objects to Add-Extension.

.OUTPUTS

System.String. Add-Extension returns a string with the extension or
file name.

.EXAMPLE

PS> extension -name "File"
File.txt

.EXAMPLE

PS> extension -name "File" -extension "doc"
File.doc

.EXAMPLE

PS> extension "File" "doc"
File.doc

.LINK

http://www.fabrikam.com/extension.html

.LINK

Set-Item
#>
}




# <<<<<Comment-based Help for a Script>>>>>
# The following sample script includes comment-based help. Notice the blank lines between the 
# closing #> and the Param statement. In a script that does not have a Param statement, there 
# must be at least two blank lines between the final comment in the help topic and the first 
# function declaration. Without these blank lines, Get-Help associates the help topic with the 
# function, not the script.
<#
.SYNOPSIS

Performs monthly data updates.

.DESCRIPTION

The Update-Month.ps1 script updates the registry with new data generated
during the past month and generates a report.

.PARAMETER InputPath
Specifies the path to the CSV-based input file.

.PARAMETER OutputPath
Specifies the name and path for the CSV-based output file. By default,
MonthlyUpdates.ps1 generates a name from the date and time it runs, and
saves the output in the local directory.

.INPUTS

None. You cannot pipe objects to Update-Month.ps1.

.OUTPUTS

None. Update-Month.ps1 does not generate any output.

.EXAMPLE

PS> .\Update-Month.ps1

.EXAMPLE

PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv

.EXAMPLE

PS> .\Update-Month.ps1 -inputpath C:\Data\January.csv -outputPath `
C:\Reports\2009\January.csv
#>

param ([string]$InputPath, [string]$OutPutPath)

function Get-Data1 { }

function Get-Data2 { }

function Get-Data3 { }


# The following command gets the script help. Because the script is not in a directory that is listed in the "Path" environment variable, 
# the Get-Help command that gets the script help must specify the script path.
Get-Help -Path .\update-month.ps1 -Full

