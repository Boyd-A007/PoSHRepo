param([string] $path)

$lines = Get-Content -Path $path 
$entries = @()

$i=0
foreach($line in $lines)
{
    $i++
    $pComp = [math]::Round(($i/$lines.Count) * 100)
    Write-Progress -Activity "Scanning logfile" -Status $pComp% -PercentComplete $pComp

    if($line.IndexOf("<![LOG[") -gt -1)
    {
        if($line.IndexOf("]LOG]!>") -gt -1)
        {
            #complete line
            $metaData = $line.Substring($line.IndexOf("]LOG]!>") + 7)
            $type = $metaData.substring($metaData.indexof("type=""") + 6, 1)
            $time = $metaData.substring($metaData.indexof("time=""") + 6, 11)
            $date = $metaData.substring($metaData.indexof("date=""") + 6, 10)
            $message = $line.Substring( $line.IndexOf("<![LOG[") + 7, $line.IndexOf("]LOG]!>") - 7 )

            $entry = New-Object -TypeName PSObject
            $entry | Add-Member -MemberType NoteProperty -Name Date -Value $date
            $entry | Add-Member -MemberType NoteProperty -Name Time -Value $time
            $entry | Add-Member -MemberType NoteProperty -Name Type -Value $type
            $entry | Add-Member -MemberType NoteProperty -Name Message -Value $message            
        }else
        {
            #start of a multi line message
            $message = $line.Substring( $line.IndexOf("<![LOG[") + 7)
        }
    }else
    {
        if($line.IndexOf("]LOG]!>") -gt -1)
        {
            #complete line
            $metaData = $line.Substring($line.IndexOf("]LOG]!>") + 7)
            $type = $metaData.substring($metaData.indexof("type=""") + 6, 1)
            $time = $metaData.substring($metaData.indexof("time=""") + 6, 11)
            $date = $metaData.substring($metaData.indexof("date=""") + 6, 10)
            $message = $line.Substring(0, $line.IndexOf("]LOG]!>") )

            $entry = New-Object -TypeName PSObject
            $entry | Add-Member -MemberType NoteProperty -Name Date -Value $date
            $entry | Add-Member -MemberType NoteProperty -Name Time -Value $time
            $entry | Add-Member -MemberType NoteProperty -Name Type -Value $type
            $entry | Add-Member -MemberType NoteProperty -Name Message -Value $message
        }else
        {
            $message += $line
        }        
    }
    $message

    $entries += $entry
}

#$entries