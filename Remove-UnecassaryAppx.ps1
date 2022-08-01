$Packages = 'Microsoft.3DBuilder', 'Microsoft.BingFinance', 'Microsoft.BingNews',
'Microsoft.BingSports', 'Microsoft.MicrosoftSolitaireCollection',
'microsoft.windowscommunicationsapps', 'Microsoft.WindowsPhone',
'Microsoft.XboxApp', 'Microsoft.ZuneMusic','Microsoft.ZuneVideo'
Get-AppxPackage -AllUsers | Where-Object Name -In $Packages | Remove-AppxPackage
Get-AppxProvisionedPackage -Online | Where-Object DisplayName -In $Packages | Remove-ProvisionedAppxPackage -Online | Out-Null