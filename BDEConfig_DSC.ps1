configuration BDEConfig
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    node ("localhost")
    {
        # Call Resource Provider
        WindowsFeature Microsoft-Hyper-V-Services
        {
           Ensure = "Present"
           Name   = "Microsoft-Hyper-V-Services"
        }
    }
}

BDEConfig