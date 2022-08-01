$rsA = [runspacefactory]::CreateRunspace()
$posh = [powershell]::Create()
$posh.Runspace = $rsA
$rsA.open()
[void]$posh.addscript({Get-Date; start-sleep -Seconds 10})
$asO = $posh.begininvoke()

do{
    
}while(!($asO.IsCompleted))

$data = $posh.EndInvoke($asO)
$posh.Dispose()

$data