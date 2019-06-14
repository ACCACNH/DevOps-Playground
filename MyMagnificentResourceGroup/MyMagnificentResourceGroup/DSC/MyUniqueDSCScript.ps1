Configuration Main
{

    param( 
        [string] $nodeName,
        [string] $remoteTextFile,
        [string] $remoteScriptFile,
        [string] $firstindexfile,
        [string] $secondindexfile,
        [string] $task3_67file,
        [string] $LASuserScript
    )

    Import-DscResource -Module PSDesiredStateConfiguration
    Import-DscResource -Module xPSDesiredStateConfiguration
    Import-DscResource -Module xWebAdministration
	Import-DscResource -ModuleName xNetworking
    
    Node $nodeName
    {
        File folder1 {
            DestinationPath = 'C:\inetpub\wwwroot1'
            Type            = 'Directory'
            Ensure          = "Present"
        }
        File folder2 {
            DestinationPath = 'C:\inetpub\wwwroot2'
            Type            = 'Directory'
            Ensure          = "Present"
            Force = $true
        }
        xRemoteFile firstindex {
            Uri             = $firstindexfile
            MatchSource     = $true
            DestinationPath = 'C:\inetpub\wwwroot1\firstIndex.html'
            DependsOn       = "[File]folder1"
        }
        xRemoteFile secondindex {
            Uri             = $secondindexfile
            MatchSource     = $true
            DestinationPath = 'C:\inetpub\wwwroot2\secondIndex.html'
            DependsOn       = "[File]folder2"
        }
        xRemoteFile task3_67 {
            Uri             = $task3_67file
            MatchSource     = $true
            DestinationPath = 'C:\Artifacts\task3_67.ps1'
            DependsOn = '[xRemoteFile]LASuserScript'
        }
        xRemoteFile LASuserScript {
            Uri             = $LASuserScript
            MatchSource     = $true
            DestinationPath = 'C:\Artifacts\Add_Account_To_LogonAsService.ps1'
        }
        xRemoteFile textFileDownload {
            Uri             = $remoteTextFile
            MatchSource     = $true
            DestinationPath = "C:\Artifacts\textFile.txt"
        }

        xRemoteFile scriptFileDownload {
            Uri             = $remoteScriptFile
            DestinationPath = "C:\Artifacts\4Task.ps1"
        }

        xWebAppPool 'DefaultCompanyXAppPool' {
            Name = 'CompanyXAppPool'
        }

        WindowsFeature IIS {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        WindowsFeature Management {
 
            Name      = 'Web-Mgmt-Service'
            Ensure    = 'Present'
            DependsOn = @('[WindowsFeature]IIS')
        }

        xWebSite 'DefaultCompanyXSite1' {
            Name            = 'CompanyXSite1'
            BindingInfo     = @( MSFT_xWebBindingInformation {
                    Protocol = 'HTTP'
                    Port     = 88
                }
            )
            PhysicalPath    = 'C:\inetpub\wwwroot1'
            ApplicationPool = 'CompanyXAppPool'
            DependsOn       = '[xWebAppPool]DefaultCompanyXAppPool'
        }

        xWebSite 'DefaultCompanyXSite2' {
            Name            = 'CompanyXSite2'
            BindingInfo     = @( MSFT_xWebBindingInformation {
                    Protocol = 'HTTP'
                    Port     = 82
                }
            )
            PhysicalPath    = 'C:\inetpub\wwwroot2'
            ApplicationPool = 'CompanyXAppPool'
            DependsOn       = '[xWebAppPool]DefaultCompanyXAppPool'
        }

		xFirewall DockerSwarmTCP
        {
            Name        = 'randomTCPport'
            DisplayName = 'TCP port'
            Action      = 'Allow'
            Direction   = 'Inbound'
            LocalPort   = ('443')
            Protocol    = 'TCP'
            Profile     = 'Any'
            Enabled     = 'True'
        }

        Script ExecuteTask3_67 {
            GetScript = {}
            TestScript = {}
            SetScript = { C:\Artifacts\task3_67.ps1 }
            DependsOn = '[xRemoteFile]task3_67'
        }
    }
}