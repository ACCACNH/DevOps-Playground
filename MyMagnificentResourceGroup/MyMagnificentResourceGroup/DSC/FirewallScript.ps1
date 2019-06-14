Configuration Main
{

Param ( [string] $nodeName )

Import-DscResource -ModuleName xNetworking

Node $nodeName
  {
   
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
  }
}