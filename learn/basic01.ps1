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

# output messages
# A good script generally use Write-Verbose a lot! 
# The perfect PowerShell script/function uses all of the above in the right mix for the best user/developer experience.
# 
# - Write-Host          in PowersShell 5+, internally use Write-Information
# - Write-Progress      
# - Write-Output        stream #1  Success Stream
# - Write-Error/Throw   stream #2  Error Stream
# - Write-Warning       stream #3  Warning Stream
# - Write-Verbose       stream #4  Verbose Stream
# - Write-Debug         stream #5  Debug Stream
# - Write-Information   stream #6  Information Stream, introduced in PowerShell 5
#                       stream *   All Streams


# <<<<< Write-Verbose and Write-Debug >>>>>
# e.g. we have a function
function Get-Sum {
    #  we turned our function into what is called an "advanced function" that offers support for native cmdlet
    [CmdletBinding()]
    param (
        [int] $a,
        [int] $b
    )
    Write-Verbose ("[Verbose output] About to add [{0}] and [{1}]" -f $a, $b)
    Write-Debug ("[Debug output] About to add [{0}] and [{1}]" -f $a, $b)
    Write-Debug ("[Debug output] another debug line")
    $a + $b
}
# call it without -Verbose, won't print the verbose line
Get-Sum -a 1 -b 2
# call it with -Verbose, print the verbose line
Get-Sum -a 1 -b 2 -Verbose
# call it with -Debug will stop the command at where we have Write-Debug
Get-Sum -a 1 -b 2 -Debug
# call it with -Debug and -Verbose
Get-Sum -a 1 -b 2 -Debug -Verbose


# <<<<<Write-Host>>>>>
# this is quite simply the cmdlet to use to write information to the console that you want the user of your script see.
# The output written this way is always displayed. It has color support too!
Write-Host "This text will be displayed on the console!"
Write-Host "This is yellow text on red background!" -BackgroundColor Red -ForegroundColor Yellow
0..20 | ForEach-Object { Write-Host '.' -NoNewline} # no line break at the end

# <<<<<Write-Output>>>>>
# This cmdlet is used to write output to the pipeline. If it is part of a pipeline, the output is passed down to the receiving command. 
# The values written this way can be captured into a variable. It gets written to the console if it is not passed down the pipeline or 
# assigned to a variable. This is also the same as simply stating something like a variable or a constant (makes it a return value) on its 
# own line by itself within your code, without any assignment. The output written this way can be discarded by piping the to Out-Null. 
# Pass-thru the pipeline
Write-Output "My return value" | Out-GridView
# Assign to a variable
$myString = Write-Output "My return value"
$myString
# Writing output without using Write-Output cmdlet
function Get-Sum2($a, $b)
{
   $a + $b
   # "$a + $b" is the same as saying "Write-Output ($a + $b)"
   # also return $a + $b is okay
}
# Returning values "intact"
# Sometimes, complex datatypes get mangled by PowerShell after being output. They get turned into simpler datatypes one level down in the 
# object hierarchy. For example when a .NET DataTable is returned, it may turn that into a array of .NET DataRow objects which is the immediate 
# child type in the object hierarchy of DataTable. To prevent this, just prefix the return line with a “comma”. This will prevent PowerShell 
# from un-nesting/interpreting your output.
function Get-DataTable()
{
   #Some logic...followed by return value
   #The comma prefix will write to pipeline with value intact!
   ,$myDataTable
}
# Out-Null
# This cmdlet lets you discard any output as if the output was never done. It not only suppresses console output messages but also throws away 
# actual output returned to the pipeline by other commands. This comes in handy if you have written all of your scripts with a lot of output to
# the console and for a specific need, you do not want to clutter up the screen (or) you have no need for the return value a function produces.
Write-Output "Send text the console?" | Out-Null


# <<<<<Write-Debug>>>>>
# If you are running with the “-Debug” switch, then control will break on the line of code that has “Write-Debug” allowing you to step through code
# from that statement forward. It is a pretty cool feature if you think about it. Typically, you run code without out the Debug switch. However, 
# there will come a time when you want to break inside your main loops where you have the most important logic and step through code without having 
# to dig through all the code. Sprinkle your code with a couple of “Write-Debug” statements per function where you think that you may want to start
# examining variable values and start stepping through the individual statements.


# <<<<<Write-Warning>>>>>
# Write-Warning has a color coding that catches the attention of the user. Use this when you want to let the user know that something is not normal
# but the code has to continue anyway as it not a big enough problem to stop execution. Examples of this are when you want to copy files over to a new 
# location and the files already exist in that target location. If the business process allows overwriting the target, it still might be a good idea to 
# let the user know that you are overwriting with “Write-Warning” type messages.
Write-Warning "Hello, this is a warning message"


# <<<<<Write-Error/Throw>>>>>
# Write-Error is to be used for non-terminating errors – meaning, the execution will continue past the Write-Error line after writing the error to the 
# error stream. Write-Error has a lot of parameters that lets you customize it. The key among them is the Category parameter. Although it used to 
# signal non-terminating errors, you can in fact stop the execution by setting the environment $ErrorActionPreference.
# $ErrorActionPreference = "Stop";
Write-Error "Unable to connect to server." -Category ConnectionError
Write-Host "The above is non-terminating, there we can reach here"


# <<<<<Throw>>>>>
# Use Throw when you want the program execution to stop (unless there was a try/catch to handle the error and resume from it).
function Get-Dummy() {
    # throw string
    throw "This is an error."
    # throw object
    # throw (get-process PowerShell)
    # afterwards, we can use $error[0].targetobject to examine the error
}

Get-Dummy


# <<<<<Write-Verbose>>>>>
# This is the most commonly used of all the ones discussed. Basically, this is all the extra information you want to see as your program is running 
# if it was started with the “-Verbose” switch. Typically code is run without that switch. I usually use for every step within a function. In addition 
# to giving me an idea of what is being worked on, if an error happens, I also get the step that failed


# <<<<<Write-Progress>>>>>
# example 1
for($i = 1; $i -lt 101; $i++ )
{
    Write-Progress -Id 1 -Activity "Application update ..." -Status 'Progress' -PercentComplete $i -CurrentOperation "Outer loop processing "
    for($j = 1; $j -lt 101; $j++ )
    {
        Write-Progress -Id 2 -Activity "Install application patch $i ..." -Status 'Progress' -PercentComplete $j -CurrentOperation "Inner loop processing"
    }
}


# example 2
$outerLoopMax = 255
$innerLoopMax = 126
for ($outerCounter=1; $outerCounter -lt $outerLoopMax; $outerCounter++) {
  Write-Progress -Activity "Main loop progress:" `
                   -PercentComplete ([int](100 * $outerCounter / $outerLoopMax)) `
                   -CurrentOperation ("Completed {0}%" -f ([int](100 * $outerCounter / $outerLoopMax))) `
                   -Status ("Outer loop working on item [{0}]" -f $outerCounter) `
                   -Id 1
 
    Start-Sleep -Milliseconds 100
 
    for ($innerCounter=1; $innerCounter -lt $innerLoopMax; $innerCounter++) {
      Write-Progress -Activity "Inner loop progress:" `
                       -PercentComplete ([int](100 * $innerCounter / $innerLoopMax)) `
                       -CurrentOperation ("Completed {0}%" -f ([int](100 * $innerCounter / $innerLoopMax))) `
                       -Status ("Inner loop working on item [{0}]" -f $innerCounter) `
                       -Id 2 `
                       -ParentId 1
 
        Start-Sleep -Milliseconds 10
    }
}


# <<<<<Write-Information>>>>>
# The problem of Write-Host
# Write-Host doesn't go to a stream, It goes straight to the host program, such as the console, ISE, or PowerShell Studio
# if you put Write-Host in a script, the end-user can't suppress it, can't save it, and can't redirect it.
# - You can't suppress Write-Host output because there's no preference that silences it.
# - You can’t save Write-Host output in a variable, because the assignment operator uses the output stream. The Write-Host output 
#   is written to the host program, but the variable is empty.
# - You can't pass Write-Host output down the pipeline, because only the output stream goes down the pipeline.
# - You can't redirect Write-Host output, because redirection sends output from one stream to another, and Write-Host isn't part of any stream.
# This most elegant solution is provided by the information stream and the Write-Information cmdlet. The information stream is a new output stream that works much like the error and warning streams.
# which has all the benefits above
# The information stream has a preference variable, $InformationPreference, with a default value of SilentlyContinue, 
# and a common parameter, InformationAction, to override the preference for the current command. It also has an InformationVariable 
# common parameter that saves the stream content in the specified variable.
# The new cmdlet, Write-Information, provides information to the user without polluting the output stream. Think of it as a rework of Write-Host(in PowerShell 5+). Both Write-Host and 
# Write-Information write to the information stream, but they behave differently, because Write-Host must be backward compatible.

# it will write into InformationRecord objects, the output is determined by the 
# $InformationPreference variable, which is set to SilentlyContinue by default
# the below line print nothing
Write-Information -MessageData 'Hello from information'
$InformationPreference

$InformationPreference = 'Continue' # The global setting
Write-Information -MessageData 'Hello from information'

$InformationPreference = 'SilentlyContinue' # The global setting
Write-Information -MessageData 'Hello from information' -InformationAction Continue # the local setting

# Now after Powershell 5+, Save the output of Write-Host and Write-Information output in a variable using InformationVariable
Write-Information -MessageData 'Hello from information' -InformationVariable informationMessage
$informationMessage
Write-Host -Object 'Hello from information' -InformationVariable hostMessage
$hostMessage
# Because they write to the information stream (stream #6), you can redirect the output of
# Write-Host and Write-Information to a file.
Write-Host -Object 'Hello from host' 6> .\hostmsg.txt

# Key difference between Write-Host and Write-Information
# - Write-Information responds to the values of the $InformationPreference variable and the InformationAction common parameter. Write-Host does not.
# - Write-Host has parameters that change its display, for example, ForegroundColor and BackgroundColor. Write-Information does not.


#########################################
# Understand Streams, Redirection and Write-Host
#########################################
# By default, PowerShell sends its command output to the PowerShell console. However, you can direct the output to a text file,
# and you can redirect error output to the regular output stream.
# You can use the following methods to redirect output:
# - Use the Out-File cmdlet, which sends command output to a text file. Typically, you use the Out-File 
#   cmdlet when you need to use its parameters, such as the Encoding, Force, Width, or NoClobber parameters.
# - Use the Tee-Object cmdlet, which sends command output to a text file and then sends it to the pipeline.
# - Use the PowerShell redirection operators.

# The PowerShell redirection operators are as follows, where n represents the stream number. 
# The Success stream #1  is the default if no stream is specified.
# >	    Send specified stream to a file.	                        n>
# >>	Append specified stream to a file.	                        n>>
# >&1	Redirects the specified stream to the Success stream.	    n>&1

# e.g. Redirect both errors and output to one file
# where C: is existed but Z: is not, the error message of Z: not found will be put into stream#2 and we
# will redirected the Error stream to success stream
# 2 is Error stream, 1 is the Success stream
# This example runs dir on one item that will succeed, and one that will error.
# It uses 2>&1 to redirect the Error stream to the Success stream, and > to send the resultant Success stream to a file called dir.log
Get-ChildItem 'C:\', 'Z:\' 2>&1 > result.log


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
# get the complete help documentation
Get-Help Get-Command -Full
# get the member of the result
Get-Process | Get-Member # gps | gm  or Get-Process | gm
# If you get confused in the pipeline use `Get-Member` for an overview
# of the available methods and properties of the pipelined objects:
ls | Get-Member
Get-Date | gm

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


##################################################
# Viewing Object Structure
##################################################
# Because objects play such a central role in Windows PowerShell, there are several native commands 
# designed to work with arbitrary object types. The most important one is the Get-Member command.
# The simplest technique for analyzing the objects that a command returns is to pipe the output of 
# that command to the Get-Member cmdlet. The Get-Member cmdlet shows you the formal name of the object type and a complete listing of its members. The number of elements that are returned can sometimes be overwhelming. For example, a process object can have over 100 members.
# To see all the members of a Process object and page the output so you can view all of it, type:
# e.g.
Get-Process | Get-Member 

# We can make this long list of information more usable by filtering for elements we want to see.
# The Get-Member command lets you list only members that are properties. There are several forms of
# properties. The cmdlet displays properties of any type if we set the Get-Member MemberType
# parameter to the value Properties. The resulting list is still very long, but a bit more manageable:
Get-Process | Get-Member -MemberType Property
# The allowed values of MemberType are 
#   - AliasProperty 
#   - CodeProperty 
#   - Property 
#   - NoteProperty 
#   - ScriptProperty 
#   - Properties 
#   - PropertySet 
#   - Method 
#   - CodeMethod 
#   - ScriptMethod 
#   - Methods
#   - ParameterizedProperty
#   - MemberSet
#   - All

##################################################
# Get Object Type
# GetType() method available on all objects in PowerShell
##################################################
$result = Get-Process
$result.GetType()
# or directly
(Get-Process).GetType()


"Hello".GetType().FullName            
(4).GetType().FullName            
(2.6).GetType().FullName            
(Get-Date).GetType().FullName


#################################################
# Using Format commands to change the output
# to get the what they are?
# Get-Command -Verb Format -Module Microsoft.PowerShell.Utility
#################################################
# PowerShell has a set of cmdlets that allow you to control how properties are displayed for 
# particular objects. The names of all the cmdlets begin with the verb Format.
# the important ones are:
#    - Format-Table
#    - Format-List
#    - Format-Table
# Each object type in PowerShell has default properties that are used when you don't specify which 
# properties to display. Each cmdlet also uses the same Property parameter to specify which properties
# you want to display. Because Format-Wide only shows a single property, its Property parameter only takes 
# a single value, but the property parameters of Format-List and Format-Table accept a list of property 
# names.

# Format-Wide
# The Format-Wide cmdlet, by default, displays only the default property of an object. The information associated with each object is displayed in a single column:
Get-Process -Name chrome | Format-Wide
# or we can specify the non default property that want to display
Get-Process -Name chrome | Format-Wide -Property CPU
# With the Format-Wide cmdlet, you can only display a single property at a time. This makes it useful for displaying large lists in multiple columns.
Get-Process -Name chrome | Format-Wide -Property CPU -Column 4



# Format-List
# The Format-List cmdlet displays an object in the form of a listing, with each property labeled and displayed on a separate line:
Get-Process -Name chrome | Format-List
# specify any other non-default properties that want to be displayed
Get-Process -Name chrome | Format-List -Property ProcessName, FileVersion, StartTime, StartInfo
# The Format-List cmdlet lets you use a wildcard as the value of its Property parameter. This lets you display detailed information. Often, objects include more 
# information than you need, which is why PowerShell doesn't show all property values by default. 
# To show all of properties of an object
Get-Process -Name chrome | Format-List -Property *

# Format-Table
# If you use the Format-Table cmdlet with no property names specified to format the output of the Get-Process command, you get exactly the same output as you do 
# without a Format cmdlet. By default, PowerShell displays Process objects in a tabular format.
# therefore by default, Get-Process -Name chrome <-- is equal to --> Get-Process -Name chrome | Format-Table
# when the column is sometime too narrow to show all characters, use AutoSize
Get-Service -Name win* | Format-Table -AutoSize
Get-Service -Name win* | Format-Table -AutoSize -Wrap # if even giving AutoSize, the columns at the end still won't
                                                      # fully displayed, then add -Wrap
# Another useful parameter for tabular output control is GroupBy. Longer tabular listings in particular may be hard to compare. The GroupBy parameter groups 
# output based on a property value. For example, we can group services by StartType for easier inspection, omitting the StartType value from the property listing:
Get-Service -Name win* | Sort-Object StartType | Format-Table -GroupBy StartType



#################################################
# Select-Object
#################################################
# The Select-Object cmdlet selects specified properties of an object or set of objects. It can also 
# select unique objects, a specified number of objects, or objects in a specified position in an array.
# To select objects from a collection, use the First, Last, Unique, Skip, and Index parameters. To select 
# object properties, use the Property parameter. When you select properties, Select-Object returns new 
# objects that have only the specified properties.

# This example creates objects that have the Name, ID, and working set (WS) properties of process objects.
Get-Process | Select-Object -Property ProcessName,Id,WS
# Select processes using the most cpu
Get-Process | Sort-Object -Property CPU | Select-Object -Last 5
# Select unique characters from an array
"a","b","c","a","a","a" | Select-Object -Unique