
$myArray = "First position", 2 , "Third position", 4

foreach($element in $myArray)
 {
     ECHO $element
 }





$properties = @{
    firstname = 'Prateek'
    lastname = 'Singh'
    }



    $o = New-Object psobject -Property $properties;
    
    $o.firstname