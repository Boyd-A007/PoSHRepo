$session = New-NetEventSession -Name 'NetworkScan'
Add-NetEventProvider -Name "Microsoft-Windows-TCPIP" -SessionName 'NetworkScan'
Start-NetEventSession -Name 'NetworkScan'
Read-Host -Prompt "Press AnyKey to stop trace"
Stop-NetEventSession -Name 'NetworkScan'
$Log = Get-WinEvent -Path $session.LocalFilePath -Oldest
New-TimeSpan -end ($log | select -Last 1).timecreated -start ($log | select -first 1).Timecreated
$Log | Out-GridView
Remove-NetEventSession
