# After you've written your PowerShell module, you can add an optional module manifest that includes information about the module. 
# For example, you can describe the author, specify files in the module (such as nested modules), run scripts to customize the 
# user's environment, load type and formatting files, define system requirements, and limit the members that the module exports.


# A module manifest is a PowerShell data file (.psd1) that describes the contents of a module and determines how a module is processed.
# The manifest file is a text file that contains a hash table of keys and values. You link a manifest file to a module by naming the 
# manifest the same as the module, and storing the manifest in the module's root directory.

# For simple modules that contain only a single .psm1 or binary assembly, a module manifest is optional. But, the recommendation is to 
# use a module manifest whenever possible, as they're useful to help you organize your code and maintain versioning information. 


# The best practice to create a module manifest is to use the New-ModuleManifest cmdlet. You can use parameters to specify one or 
# more of the manifest's default keys and values. The only requirement is to name the file. New-ModuleManifest creates a module 
# manifest with your specified values, and includes the remaining keys and their default values. If you need to create multiple 
# modules, use New-ModuleManifest to create a module manifest template that can be modified for your different modules. For an 
# example of a default module manifest
# All elements of a manifest file are optional, except for the ModuleVersion number.
New-ModuleManifest -Path .\learn\modules\DummyScriptModule\DummyScriptModule.psd1 `
                   -ModuleVersion "1.0" `
                   -Author "Raymond Shen"

                   
# After you've created your module manifest, you can test it to confirm that any paths described in the manifest are correct. 
# To test your module manifest,
Test-ModuleManifest myModuleName.psd1

# for all the variables in the module manifest, please refer to
# https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest#module-manifest-elements
