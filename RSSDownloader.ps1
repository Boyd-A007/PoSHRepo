$url = "http://channel9.msdn.com/Events/Ignite/2015/RSS"
$wc = New-Object System.Net.WebClient
$feed = [xml]$wc.DownloadString($url)
$search = {"in-memory","powershell","windows 10"}

foreach($i in $feed.rss.channel.item){

    if($i.Summary -like $search){

        $fi = New-Object -TypeName PSObject
        $fi | Add-Member -MemberType NoteProperty -Name Title -Value $i.title
        $fi | Add-Member -MemberType NoteProperty -Name Summary -Value $i.summary
        $fi | Add-Member -MemberType NoteProperty -Name Link -Value $i.link

        $fi
    }
    
}