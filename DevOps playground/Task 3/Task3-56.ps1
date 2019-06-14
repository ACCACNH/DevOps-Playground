function replaceString {
    param (
        [CmdletBinding()]
        [string]$destination,
        [string]$stringToReplace,
        [string]$replaceString
    )

    (Get-Content $destination).replace($stringToReplace, $replaceString) | Set-Content $destination
}

$destination = Get-ChildItem $PSScriptRoot -recurse | where { $_.Extension -eq ".txt" } | % { $_.FullName }

replaceString -destination $destination -stringToReplace "Test" -replaceString "Production"