param (
    [CmdletBinding()]
    [Parameter(
        Mandatory = $true,
        HelpMessage = "Please enter the path to .json file",
        Position = 1
    )][string]$Path
)

$jsondata = Get-Content -Path $Path -Raw | ConvertFrom-Json 
for ($i = 0; $i -lt $jsondata.Count; $i++) {
    $jsondata[$i]
}


