. 'c:\data\scripts\Get-BUildInfo.ps1'
Add-Type -AssemblyName System.Windows.Forms
$btn_Click = {
	Get-BuildInfo -Hostname $txtHostname.Text -PrimaryUserID $txtPrimaryUserID.Text -InstallerID $txtInstallerID.Text -GroupName $txtGroupName.Text -Package $txtPackage.Text -UnattendXML $txtUnattendXML.Text
	$Form1.Close()
}
. 'c:\data\scripts\\Get-BUildInfo.form.designer.ps1'
$Form1.ShowDialog()