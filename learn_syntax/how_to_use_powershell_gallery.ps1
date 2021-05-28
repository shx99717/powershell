# The PowerShell Gallery is a package repository containing scripts, modules, and DSC resources you can download and leverage. 
# You use the cmdlets in the PowerShellGet module to install packages from the PowerShell Gallery. 

# Essentially, if you have Windows 10, you’re likely good to go. You can confirm you’re running the latest Windows Management Framework 
# by running the following command:
$PSVersionTable.PSVersion


# You can find packages in the PowerShell Gallery by using the Search control on the PowerShell Gallery's home page, or by browsing 
# through the Modules and Scripts from the Packages page. You can also find packages from the PowerShell Gallery by running the 
# Find-Module, Find-DscResource, and Find-Script cmdlets, depending on the package type, with -Repository PSGallery.

# You can filter results from the Gallery by using the following parameters:
# - Name
# - AllVersions
# - MinimumVersion
# - RequiredVersion
# - Tag
# - Includes
# - DscResource
# - RoleCapability
# - Command
# - Filter
# If you're only interested in discovering specific DSC resources in the Gallery, you can run the Find-DscResource cmdlet. Find-DscResource returns data on DSC resources contained in the Gallery. Because DSC resources are always delivered as part of a module, you still need to run Install-Module to install those DSC resources.



# PowerShellGet is a module with commands for discovering, installing, updating and publishing PowerShell artifacts like Modules, 
# DSC Resources, Role Capabilities, and Scripts.
# - Find-Command	            Finds PowerShell commands in modules.
# - Find-DscResource	        Finds a DSC resource.
# - Find-Module	                Finds modules in a repository that match specified criteria.
# - Find-RoleCapability	        Finds role capabilities in modules.
# - Find-Script	                Finds a script.
# - Get-InstalledModule	        Gets installed modules on a computer.
# - Get-InstalledScript	        Gets an installed script.
# - Get-PSRepository	        Gets PowerShell repositories.
# - Install-Module	            Downloads one or more modules from a repository, and installs them on the local computer.
# - Install-Script	            Installs a script.
# - New-ScriptFileInfo	        Creates a script file with metadata.
# - Publish-Module	            Publishes a specified module from the local computer to an online gallery.
# - Publish-Script	            Publishes a script.
# - Register-PSRepository	    Registers a PowerShell repository.
# - Save-Module	                Saves a module locally without installing it.
# - Save-Script	                Saves a script.
# - Set-PSRepository	        Sets values for a registered repository.
# - Test-ScriptFileInfo	        Validates a comment block for a script.
# - Uninstall-Module	        Uninstalls a module.
# - Uninstall-Script	        Uninstalls a script file.
# - Unregister-PSRepository	    Unregisters a repository.
# - Update-Module	            Downloads and installs the newest version of specified modules from an online gallery to the local
# - Update-ModuleManifest	    Updates a module manifest file.
# - Update-Script	            Updates a script.
# - Update-ScriptFileInfo	    Updates information for a script.


# We encourage the following process when downloading packages from the PowerShell Gallery:

# ------ Search
# e.g. use cli to search modules on Powershell Gallery
Find-Module -Name Write-ObjectToSQL -Repository PSGallery
Find-Module -Name Write-ObjectToSQL -Repository PSGallery | Get-Member
Find-Module -Repository PSGallery -Tag Hyper-V | Format-List

# ------ Inspect
# To download a package from the Gallery for inspection, run either the Save-Module or Save-Script cmdlet, depending on the package type. 
# This lets you save the package locally without installing it, and inspect the package contents. Remember to delete the saved package 
# manually.
# Some of these packages are authored by Microsoft, and others are authored by the PowerShell community. Microsoft recommends that you 
# review the contents and code of packages on this gallery prior to installation.

# As with all repositories it isn’t time to just start running your newly found script.  If the author has any website info, 
# you might want to check it our first to ensure that script does what you are expecting. You should also save the script and inspect 
# the code to ensure it aligns with your objectives.  The following two cmdlets allow you to save (not install) the script for further 
# review.
Save-Module -Name Write-ObjectToSQL -Repository PSGallery -Path "d:\temp\2020.01\ps_scripts_temp\"

# ------ Install
# To install a package from the Gallery for use, run either the Install-Module or Install-Script cmdlet, depending on the package type.
# Install-Module installs the module to $env:ProgramFiles\WindowsPowerShell\Modules by default. This requires an administrator account. 
# If you add the -Scope CurrentUser parameter, the module is installed to $env:USERPROFILE\Documents\WindowsPowerShell\Modules.

# Install-Script installs the script to $env:ProgramFiles\WindowsPowerShell\Scripts by default. This requires an administrator account. 
# If you add the -Scope CurrentUser parameter, the script is installed to $env:USERPROFILE\Documents\WindowsPowerShell\Scripts.

# By default, Install-Module and Install-Script installs the most current version of a package. To install an older version of the package, 
# add the -RequiredVersion parameter.

# Once satisfied with the contents of the script/module it’s time to download and install it.
Install-Module -Name Write-ObjectToSQL -Repository PSGallery

# ------ Update
# To update packages installed from the PowerShell Gallery, run either the [Update-Module][] or [Update-Script][] cmdlet. When run 
# without any additional parameters, [Update-Module][] attempts to update all modules installed by running Install-Module. 
# To selectively update modules, add the -Name parameter.

# Similarly, when run without any additional parameters, [Update-Script][] also attempts to update all scripts installed by 
# running Install-Script. To selectively update scripts, add the -Name parameter.
Update-Script
Update-Module


# ------ List installed modules from Powershell Gallery
# To find out which modules you have installed from the PowerShell Gallery, run the Get-InstalledModule cmdlet. 
# This command lists all of the modules you have on your system that were installed directly from the PowerShell Gallery.

# Similarly, to find out which scripts you have installed from the PowerShell Gallery, run the Get-InstalledScript cmdlet. 
# This command lists all the scripts you have on your system that were installed directly from the PowerShell Gallery.
Get-InstalledModule
Get-InstalledScript