[DSCLocalConfigurationManager()]
configuration PlatformConfig
{
    node localhost
    {
        PartialConfiguration OSPlatform
        {
            Description = 'Configuration of the Base OS'
            RefreshMode = 'Push'
        }

        PartialConfiguration IEConfig
        {
            Description = 'Internet Explorer Config'
            RefreshMode = 'Push'
        }

        PartialConfiguration BDEConfig
        {
            Description = 'Bitlocker Configuration'
            Refreshmode = 'Push'
        
        }
    }
}

PlatformConfig