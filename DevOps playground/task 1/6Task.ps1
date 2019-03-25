[CMDLetBinding()]
param (
    [Switch]$full
    )

if ($full -eq $true) {
    Echo "Getting all disks..."
    Get-Disk
} else {
    "Try adding -full"
}
        



