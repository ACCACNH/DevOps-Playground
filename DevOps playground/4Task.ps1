param (
    [CmdletBinding()]
    [Parameter(
        Mandatory = $true,
        HelpMessage = "Please enter the path to shrek",
        Position = 1
    )][string]$Directory
)
$ImageURL = "https://amp.thisisinsider.com/images/5adf9aefbd967144788b4605-750-563.jpg"
$FilePath = $Directory += "\shrek.jpg"
if (Test-Path -Path $FilePath) {
    echo "Shrek already exists in pointed directory"
} else {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
    
    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($ImageURL, $FilePath)
}


