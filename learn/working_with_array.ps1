# Initializing an Array
$array=@(1,2,3,5,6,7,8); # or $array = 1,2,3,4,5,6,7,8  PowerShell will actually treat any comma-separated list as an array
$array= 1..9

# retrieve part of the array
$array[1..4]

# Negative numbers count from the end of the array.
$array[-3..-1]


$array = 0 .. 9
$array[0,2+4..6] # you can use the plus operator (+) to combine a ranges with a list of elements in an array. For example, 
                 # to display the elements at index positions 0, 2, and 4 through 6

#Checking the Size of an Array
$array.Length

#Accessing Array Elements
$array[0] + $array[1] + $array[2]

# Initializing an Empty Array
$array = @()

# Adding Elements to an Array
$array += 1
$array += 2
$array += 3

# Removing Elements from an Array
# To remove the elements which are not required in an array, use the below command. 
# This stores only the sub-arrays mentioned here.
$array = @($array[0], $array[2])

# Looping Through an Array Using a For Loop
for($i = 0; $i -lt $array.Length; $i++) {
    $array[$i]
}

# Looping Through an Array Using a ForEach Loop
foreach($element in $array) {
    $element
}


$array = @(1, 2, 3), @(4, 5, 6), @(7, 8, 9)
$array[0]    # 1
             # 2
             # 3
$array[0][0]  # 1
$array[2][2]  # 9


# quickly looping from 0 - 100
# where here {<statement list>} is the script block
@(0..100).ForEach({
    $_ # This is the variable for the current value in the pipe line
       # $_ (dollar underscore) 'THIS' token. Typically refers to the item inside a foreach loop.
       # Task: Print all items in a collection. Solution. ... | foreach { Write-Host $_ }
});
# '%' is an alias of 'ForEach-Object'
@(0..100) | %{ Write-Host $_}
# equal to
@(0..100) | ForEach-Object { Write-Host $_}

