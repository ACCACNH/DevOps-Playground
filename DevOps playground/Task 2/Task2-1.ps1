param (
    [CmdletBinding()]
    [Parameter(
        Mandatory = $true,
        HelpMessage = "Please enter folder path",
        Position = 1
    )][string]$Directory
)

Install-Module -name Az.Storage
Import-Module -name Az.Storage

$Location = "westeurope"
$ResourceGroup = "myAbsolutelyUniqueResourceGroup"
$StorageName = "myabsolutelystorage"
$ContainerName = "myabsolutelyblobcontainer"

.\LogInAzure.ps1

Write-Host "Creating Resource group..."
New-AzResourceGroup -Name $ResourceGroup -Location $location

Write-Host "Creating Storage account..."
$storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroup `
    -Name $StorageName `
    -SkuName Standard_LRS `
    -Location $location `


$ctx = $storageAccount.Context

Write-Host "Creating blob container..."
$Container = New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob


$container.CloudBlobContainer.Uri.AbsoluteUri
if ($container) {
    $filesToUpload = Get-ChildItem $Directory -Recurse -File

    foreach ($x in $filesToUpload) {
        $targetPath = ($x.fullname.Substring($Directory.Length + 1)).Replace("\", "/")

        Write-Verbose "Uploading $("\" + $x.fullname.Substring($Directory.Length + 1)) to $($container.CloudBlobContainer.Uri.AbsoluteUri + "/" + $targetPath)"
        Set-AzStorageBlobContent -File $x.fullname -Container $container.Name -Blob $targetPath -Context $ctx -Force 
    }
}
  