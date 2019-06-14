$destinationUnzipPath = $PSScriptRoot
$zipfilePath = Get-ChildItem $PSScriptRoot -recurse | where { $_.Extension -eq ".7z" } | % { $_.FullName }

set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"
sz x $zipfilePath -o"$destinationUnzipPath" -r;