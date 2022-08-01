Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'Test-Workflow.designer.ps1')
$Form1.ShowDialog()