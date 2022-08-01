configuration OSInstall
{
    Import-DscResource –ModuleName 'PSDesiredStateConfiguration'
    node ("localhost")
    {
        # Call Resource Provider
        WindowsFeature Hyper-V-Tools
        {
           Ensure = "Present"
           Name   = "Microsoft-Hyper-V-Tools-All"
        }
    }
}

OSInstall