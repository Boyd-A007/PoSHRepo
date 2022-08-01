#Test-NetworkConnection

function CheckCable {
    $connected = $false
    $PhysicalAdapters = Get-NetAdapter -Physical | Where-Object(PhysicalMediaType -eq 802.3)
    foreach($item in $PhysicalAdapters){
        $connected = $($item.status -eq 'Up')
    }
    return $connected
}