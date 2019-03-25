param (
    [CmdletBinding()]
    [Parameter(
        Mandatory = $true,
        HelpMessage = "Please enter the path to .json file",
        Position = 1
    )][string]$Path
)

$jsondata = Get-Content -Path $Path -Raw | ConvertFrom-Json 
$jsondata.glossary.GlossDiv.GlossList.GlossEntry.SortAs = "OMPL"

#Select -expand glossary | select -expand GlossDiv | select -expand GlossList | select -expand GlossEntry |
#Select SortAs | Set "OMPL" 


$jsondata | ConvertTo-Json  -Depth 100 | set-content $Path

