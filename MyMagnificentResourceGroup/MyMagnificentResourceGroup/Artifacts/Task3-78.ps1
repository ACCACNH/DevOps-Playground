$Password = "Pa$/$/w0rd"

New-LocalUser "Riga Developer Pavils" -Password $Password -FullName "Pavils" -Description "Test account for DevOps tasks"

.\Add_Account_To_LogonAsService.ps1 "Riga Developer Pavils"

Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force