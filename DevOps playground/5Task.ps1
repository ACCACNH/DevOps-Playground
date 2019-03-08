
[string]$undefined

if (-not ([string]::IsNullOrEmpty($undefined))) #Проверка на пустоту\нулл стринга
{
    $undefined
    
} elseif ($undefined -eq "") {  #Проверка на пустоту стринга
    echo "Variable is empty. Adding value"
    $undefined = "kek text"

} else {
    echo "Variable is null. Adding value"
    $undefined = "kek text"
}
$undefined







