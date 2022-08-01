<#Prerequisites

    Client
    - Windows 10 Pro or Enterprise
    - Hyper-V Manager Installed
    - Windows PowerShell 5.1
    - Hyper-V PowerShell Module
    
    Server
    - Hyper-V Server 2019

#>

$ServerName = 'blackdragon.dragons.home'
$ServerIP = '192.168.1.9'

#Attempt PowerShell Remoting
Enter-PSSession -ComputerName $ServerName

#Add an entry to the hosts file for the host's fqdn
Get-Content -Path "C:\Windows\System32\drivers\etc\hosts"
Add-Content -Path "C:\Windows\System32\drivers\etc\hosts" -Value "$ServerIP $ServerName"

#Set Adapter Connection to Private
Get-NetConnectionProfile
Set-NetConnectionProfile -InterfaceAlias "*Ethernet*" -NetworkCategory Private

#Configure PowerShell Remoting
Enable-PSRemoting

#Add the entire domain for delegation (Handy if you have more than one Host)
Get-WSManCredSSP
Enable-WSManCredSSP -Role Client -DelegateComputer "enter"

#Add all hosts in the entire domain to the Trusted Hosts (Handy if you have more than one Host)
Get-Item -Path WSMan:\localhost\Client\TrustedHosts
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value "*.dragons.home"

#Add credentials for each computer
cmdkey /list
cmdkey /add:blackdragon.dragons.home /user:Administrator /pass:!e8ru0wu#

#Verify PowerShell Remoting is operational
Enter-PSSession -ComputerName blackdragon.dragons.home
