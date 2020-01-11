# A script module is any valid PowerShell script saved in a .psm1 extension. This extension allows the PowerShell engine to use 
# rules and module cmdlets on your file. Most of these capabilities are there to help you install your code on other systems, 
# as well as manage scoping. You can also use a module manifest file, which describes more complex installations and solutions.


# script module need to be saved in .psm1 file
# The script and the directory where it's stored must use the same name. For example, a script named MyPsScript.psm1 is 
# stored in a directory named MyPsScript.

# The module's directory needs to be in a path specified in $env:PSModulePath. The module's directory can contain any 
# resources that are needed to run the script, and a module manifest file that describes to PowerShell how your module works.

# see module/DummyScriptModule/DummyScriptModule.psm1 for more details