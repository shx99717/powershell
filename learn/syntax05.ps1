#######################################
# ConvertTo-*
#######################################
# - ConvertTo-Csv                      
# - ConvertTo-Html                    
# - ConvertTo-Json                     
# - ConvertTo-ProcessMitigationPolicy 
# - ConvertTo-SecureString             
# - ConvertTo-TpmOwnerAuth 
# - ConvertTo-Xml                  

Get-Date | Select-Object -Property * | ConvertTo-Xml -As "string"
Get-Date | Select-Object -Property * | ConvertTo-Json

#######################################
# ConvertFrom-*
#######################################
# - ConvertFrom-CIPolicy                               
# - ConvertFrom-Csv                                         
# - ConvertFrom-Json                                       
# - ConvertFrom-SecureString                           
# - ConvertFrom-String                                     
# - ConvertFrom-StringData                             

# The example uses the Select-Object cmdlet to get all of the properties of the DateTime 
# object. It uses the ConvertTo-Json cmdlet to convert the DateTime object to a string 
# formatted as a JSON object and the ConvertFrom-Json cmdlet to convert the JSON-formatted 
# string to a PSCustomObject object. 
Get-Date | Select-Object -Property * | ConvertTo-Json | ConvertFrom-Json


