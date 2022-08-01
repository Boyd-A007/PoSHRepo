configuration IEConfig
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    node ("localhost")
    {
        # Call Resource Provider
        WindowsFeature TelnetClient
        {
           Ensure = "Present"
           Name   = "TelnetClient"
        }
    }
}

IEConfig