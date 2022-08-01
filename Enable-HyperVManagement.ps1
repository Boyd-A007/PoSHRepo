Get-NetConnectionProfile | FL
Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private

Enable-PSRemoting

Get-WSManCredSSP | FL

Enable-WSManCredSSP -Role Client -DelegateComputer "*.dragons.engineering.home", "*.dragons.home", "blackdragon"

GCI -Path WSMan:\localhost\Client\TrustedHosts | FL
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value @("*.dragons.engineering.home", "*.dragons.home", "blackdragon")

cmdkey /list 
cmdkey /add:blackdragons.dragons.home /user:blackdragon\administrator /pass:!e8ru0wu#