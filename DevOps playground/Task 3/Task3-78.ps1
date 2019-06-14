$Password = "Pa$/$/w0rd"

New-LocalUser "Riga Developer Pavils" -Password $Password -FullName "Pavils" -Description "Test account for DevOps tasks"

.\Add Account To LogonAsService.ps1 "Riga Developer Pavils"

Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force

## Скрипт засунут в Artifacts папку у АРМ темплейта и вызывается в DSC на ВМке