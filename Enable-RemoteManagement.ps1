Set-NetConnectionProfile -InterfaceAlias * -NetworkCategory Private
Get-NetConnectionProfile | FL

Enable-PSRemoting -Force
Get-WSManCredSSP | FL

Enable-WSManCredSSP -Role Client -DelegateComputer "*.dragons.home", "*.dragons.engineering.home", "blackdragon" -Force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "blackdragon" -Force
Get-Item WSMan:\localhost\Client\TrustedHosts | FL

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name AllowFreshCredentials -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name AllowFreshCredentialsWhenNTLMOnly -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name ConcatenateDefaults_AllowFresh -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation" -Name ConcatenateDefaults_AllowFreshNTLMOnly -Value 1 -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials" -Name 1 -Value wsman/*.dragons.home -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials" -Name 2 -Value wsman/*.dragons.engineering.home -Force
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly" -Name 1 -Value wsman/*.dragons.home -Force

cmdkey /list 
cmdkey /add:blackdragons /user:blackdragon\administrator /pass:!e8ru0wu#


gwmi win32_volume | ft DriveLetter, FreeSpace, Capacity, @{Label=”PercentFree”;Expression= {“{0:P}” -f ($_.freespace / $_.capacity)}}