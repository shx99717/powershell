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