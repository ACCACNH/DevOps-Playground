function Get-IPv4Address
{Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Ethernet" | Select-Object IPAddress}

function Get-MultiplyResult {

    Param ([int]$a,[int]$b)
    
    $c = $a * $b
    
    Write-Output $c
    
    }