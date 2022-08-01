ipmo *bits*
1..1000|ForEach-Object{
	Clear-Host;
	"last update $(Get-Date)"
	Get-BitsTransfer | where {$_.jobstate -ne "transferred"} | Select jobid, jobstate, @{Label="percent complete"; EXPRESSION={($_.BytesTransferred/$_.BytesTotal*100)}}
	Get-BitsTransfer | where {$_.jobstate -eq "transferred"} | Select jobid, jobstate
	Get-BitsTransfer | where {$_.jobstate -eq "transferred"} | Complete-BitsTransfer
	Sleep 300 
}