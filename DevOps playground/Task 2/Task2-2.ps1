$Location = "westeurope"
$ResourceGroupName = "myAbsolutelyUniqueResourceGroup"

$serverName = "server-$(Get-Random)"

$adminSqlLogin = "SqlAdmin"
$password = "OmegaStrongSQLPassword1"

[string[]]$dbNames = "db-$(Get-Random)", "db-$(Get-Random)", "db-$(Get-Random)"

$startIp = "0.0.0.0"
$endIp = "255.255.255.255"

.\LogInAzure.ps1

New-AzResourceGroup -Name $ResourceGroupName -Location $location -Force

Write-Host "Creating SQL server $serverName"
$server = New-AzSqlServer -ResourceGroupName $ResourceGroupName `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials $(New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminSqlLogin, $(ConvertTo-SecureString -String $password -AsPlainText -Force))

Write-Host "Adding firewall rule"
New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroupName `
    -ServerName $serverName `
    -FirewallRuleName "AllowedIPs" -StartIpAddress $startIp -EndIpAddress $endIp

Write-Host "Starting to cerate databases"
foreach ($dbName in $dbNames) {
    Write-Host "Creating database $dbName"
    New-AzSqlDatabase  -ResourceGroupName $ResourceGroupName `
        -ServerName $serverName `
        -DatabaseName $dbName `
        -RequestedServiceObjectiveName "S0" `

    Write-Host "Filling the database with data"
    $QueryParams = @{

        'Database'        = $dbName
          
        'ServerInstance'  = $server.FullyQualifiedDomainName
          
        'Username'        = $adminSqlLogin
          
        'Password'        = $password
          
        'OutputSqlErrors' = $true
          
        'Query'           = 'CREATE TABLE Persons (
                PersonID int,
                LastName varchar(255),
                FirstName varchar(255),
                Address varchar(255),
                City varchar(255) 
            );
     '
    }
    Invoke-Sqlcmd @QueryParams
$QueryParams.Query = "INSERT INTO Persons (PersonID,LastName,FirstName,Address,City) VALUES (1,'Gulenko','Pablo','RandomAdress','Riga');"
Invoke-Sqlcmd @QueryParams
}

$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SqlConnection.ConnectionString = "Server = $($server.FullyQualifiedDomainName); Database = $($dbNames[0]); Integrated Security = False; User ID = $adminSqlLogin; Password = $password;"
.\ExportDB.ps1 -ConnectionString $SqlConnection.ConnectionString -DatabaseName $dbNames[0] -OutputFile "C:\Users\Pavils.gulenko\Desktop\DevOps playground\Task 2\Backup\$($dbNames[0]).bacpac"
.\ImportDB.ps1 -ConnectionString $SqlConnection.ConnectionString -DatabaseName $dbNames[2] -OutputFile "C:\Users\Pavils.gulenko\Desktop\DevOps playground\Task 2\Backup\$($dbNames[0]).bacpac"
