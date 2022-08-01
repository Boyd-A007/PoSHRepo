param([string]$feedUrl="http://s.ch9.ms/Feeds/RSS/",
[string]$mediaType = "mp4high",
[string]$search="powershell",
[switch]$overwrite=$false,
[string]$destinationDirectory=(join-path ([Environment]::GetFolderPath("MyVideo")) "channel9") )
 
# --- locals ---
$webClient = New-Object System.Net.WebClient
 
# --- functions ---
 
function DownloadEntries {
 param ([string]$feedUrl, [string]$search) 
 $feed = [xml]$webClient.DownloadString($feedUrl)
 
 $progress = 0
 $pagepercent = 0
 $entries = $feed.rss.channel.item.Length
 $invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
 $feed.rss.channel.item | foreach {
    $url = New-Object System.Uri($_.enclosure.url)
    $name = $_.title
    $desc = $_.description
    $extension = [System.IO.Path]::GetExtension($url.Segments[-1])
    $fileName = $name + $extension
 
    $invalidchars | foreach { $filename = $filename.Replace($_, ' ') }
    $saveFileName = join-path $destinationDirectory $fileName
    $tempFilename = $saveFilename + ".tmp"
    $filename
    if ((-not $overwrite) -and (Test-Path -path $saveFileName)) 
    {
        write-progress -activity "$fileName already downloaded" -status "$pagepercent% ($progress / $entries) complete" -percentcomplete $pagepercent
    }
    else 
    {
        write-progress -activity "Downloading $fileName" -status "$pagepercent% ($progress / $entries) complete" -percentcomplete $pagepercent
        $webClient.DownloadFile($url, $tempFilename)
        rename-item $tempFilename $saveFileName
    }
    $pagepercent = [Math]::floor((++$progress)/$entries*100)
  }
}  
 
# --- do the actual work ---
$feedUrl += $mediaType
 
# if dest dir doesn't exist, create it
if (!(Test-Path -path $destinationDirectory)) { New-Item $destinationDirectory -type directory }
 
DownloadEntries $feedUrl