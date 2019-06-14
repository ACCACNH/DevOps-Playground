New-Item -type directory -path C:\MyFolder

$Acl = Get-Acl "C:\MyFullAccessFolder"
$Ar = New-Object  system.security.accesscontrol.filesystemaccessrule("Riga Developer Pavils","FullControl","Allow")
$Acl.SetAccessRule($Ar)

Set-Acl "C:\MyFullAccessFolder" $Acl