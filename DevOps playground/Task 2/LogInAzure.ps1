$CertSubject = "CN=Pavils" 
$TenantId = "fc13f44c-0262-41a4-9fc5-6446f1fabae9"
$ApplicationId = "9ea7cfb3-3aa8-4a05-8e41-e9ad565f30bd" #Principle ID in portal
$Thumbprint = (Get-ChildItem cert:\CurrentUser\My\ | Where-Object {$_.Subject -eq $CertSubject }).Thumbprint

Write-Host "Logging into Azure..."
Login-AzAccount -ServicePrincipal -CertificateThumbprint $Thumbprint -TenantId $TenantId -ApplicationId $ApplicationId

Set-AzContext -Tenant $TenantId