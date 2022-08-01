while($true)
{
    cls   
    $w = (New-Object net.webclient).DownloadString("https://api.spark.io/v1/devices/55ff6f064989495342512587/temperature?access_token=c6c294c99f1aa056ac972903693cd034a8eb1745")
    $xml = ConvertFrom-Json($w)
    $rawTemp = $xml.result

    [float]$temperature = [System.Math]::Log(((40960000/$rawTemp)-10000))
    $temperature = 1/(0.001129148 + (0.000234125 + (0.0000000876741 * $temperature * $temperature))* $temperature)
    $temperature = $temperature - 273.15
    $temperature = ($temperature * 9.0)/5.0 + 32.0
    $temperature
    sleep(3)
}

