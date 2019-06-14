#Import-Module PowerShellAccessControl
#Get-Service spooler | Add-AccessControlEntry -ServiceAccessRights Full -Principal Pavils Riga Developer\tuser


cd "C:\Program Files (x86)\Windows Resource Kits\Tools\"
.\subinacl.exe /service TapiSrv /grant='Pavils Riga Developer'\tuser=F