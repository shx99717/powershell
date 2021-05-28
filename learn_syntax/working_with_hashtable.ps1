# Initializing a Hash Table
$pets = @{Cat = 'Frisky'; Dog = 'Spot'; Fish = 'Nimo'; Hamster = 'Whiskers'}

# Accessing Hash Table Items
$pets.Cat    # Frisky
$pets.Dog    # Spot
$pets.Fish    # Nimo
$pets.Hamster  # Whiskers

# Initializing an Empty Hash Table
$pets = @{}

# Adding Items to a Hash Table
# way 1:
$pets.Add('Cat', 'Frisky')
$pets.Add('Dog', 'Spot')
$pets.Add('Fish', 'Nimo')
$pets.Add('Hamster', 'Whiskers')
# way 2:
$pets.Cat = 'Frisky'
$pets.Dog = 'Spot'
$pets.Fish = 'Nimo'
$pets.Hamster = 'Whiskers'

# Removing Items from a Hash Table
$pets.Remove('Hamster')


# Looping Through a Hash Table Using ForEach
foreach($pet in $pets.keys) {
    $pet # Print each Key
    $pets.$pet # Print value of each Key
}


# Format-Table
# The Format-Table cmdlet formats hash table output as a table.
$pets | Format-Table

# Format-List
# The Format-List cmdlet formats hash table output as a list of separate key-value pairs.[2]
$pets | Format-List
