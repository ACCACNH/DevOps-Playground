
param (
    [CmdletBinding()]
    [Parameter(
        Mandatory=$true,
        HelpMessage ="Please enter the path where .xml lies",
        Position=1
        )][string]$Path,
    [Parameter(
        Mandatory=$true,
        HelpMessage="Please, specify the existing .xml file name",
        Position = 2
        )][string]$FileName,
    [Parameter(
        Mandatory=$true,
        HelpMessage="Please, specify the save path of .xml files",
        Position=3)][string]$SavePath
)
$xmlFullPath = ("{0}{1}" -f $Path, $FileName)
$copyCount = 10;

$xml = New-Object XML
$xml.Load($xmlFullPath)

for ($i = 1; $i -le $copyCount; $i++) {  
    foreach ($element in $xml.SelectNodes("//th")) {
        $element.InnerText = "test" + $i.ToString()
    } 
    $xmlSavePath = ("{0}\{1}" -f $SavePath, $i.ToString())
    $xml.Save($xmlSavePath+".XML")
}
