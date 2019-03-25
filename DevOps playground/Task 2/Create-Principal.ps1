#Variables
$Subject = "CN=Pavils"                                  # Change GITLAB with the appropriate one for you
$CertStoreLocation = "cert:\CurrentUser\My"
$SubscriptionId = "227e6f3b-e3c1-49ee-ae4c-00c67e640ba1"                                   #Add your subscription ID
$DisplayName = "Pavils"                                 # Change GITLAB for your certificate CN  value
$TenantId = "fc13f44c-0262-41a4-9fc5-6446f1fabae9"
                                         #Add your App ID

# Create a self signed cert and grant rights
echo "Attempting to create a self-signed certificate..."
$cert = New-SelfSignedCertificate -CertStoreLocation $CertStoreLocation -Subject $Subject -KeySpec KeyExchange

$keyValue = [System.Convert]::ToBase64String($cert.GetRawCertData())

# Login as the user
echo "Logging in Azure..."
Login-AzAccount -TenantId $TenantId
Set-AzContext -SubscriptionId $SubscriptionId 
echo "Attempting to create Service Principle... Might take a minute..."
# Create the Service Principal
$sp = New-AzADServicePrincipal -DisplayName $DisplayName `
   -CertValue $keyValue `
   -EndDate $cert.NotAfter `
   -StartDate $cert.NotBefore

# Sleep for a while to make sure the Principal is created
Start-Sleep 60

#Grant Contributor to the new Service Principal
echo "Assigning a new role to principal..."
New-AzRoleAssignment -RoleDefinitionName "Contributor" -ServicePrincipalName $sp.ApplicationId

