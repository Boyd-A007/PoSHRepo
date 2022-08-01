$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$btn = $null
[System.Windows.Forms.Label]$lblHostname = $null
[System.Windows.Forms.TextBox]$txtHostname = $null
[System.Windows.Forms.Label]$lblPrimaryUserID = $null
[System.Windows.Forms.TextBox]$txtPrimaryUserID = $null
[System.Windows.Forms.Label]$lblInstallerID = $null
[System.Windows.Forms.TextBox]$txtInstallerID = $null
[System.Windows.Forms.Label]$lblGroupName = $null
[System.Windows.Forms.TextBox]$txtGroupName = $null
[System.Windows.Forms.Label]$lblPackage = $null
[System.Windows.Forms.TextBox]$txtPackage = $null
[System.Windows.Forms.Label]$lblUnattendXML = $null
[System.Windows.Forms.TextBox]$txtUnattendXML = $null
function InitializeComponent
{
$btn = (New-Object -TypeName System.Windows.Forms.Button)
$lblHostname = (New-Object -TypeName System.Windows.Forms.Label)
$txtHostname = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblPrimaryUserID = (New-Object -TypeName System.Windows.Forms.Label)
$txtPrimaryUserID = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblInstallerID = (New-Object -TypeName System.Windows.Forms.Label)
$txtInstallerID = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblGroupName = (New-Object -TypeName System.Windows.Forms.Label)
$txtGroupName = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblPackage = (New-Object -TypeName System.Windows.Forms.Label)
$txtPackage = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblUnattendXML = (New-Object -TypeName System.Windows.Forms.Label)
$txtUnattendXML = (New-Object -TypeName System.Windows.Forms.TextBox)
$form1.SuspendLayout()
#
# lblHostname
#
$lblHostname.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]10))
$lblHostname.Name = [System.String]'lblHostname'
$lblHostname.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblHostname.TabIndex = 1
$lblHostname.Text = 'Hostname'
$lblHostname.UseCompatibleTextRendering = $true
#
# txtHostname
#
$txtHostname.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]10))
$txtHostname.Name = [System.String]'txtHostname'
$txtHostname.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtHostname.TabIndex = 2
$txtHostname.Text = 'Auto'
#
# lblPrimaryUserID
#
$lblPrimaryUserID.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]40))
$lblPrimaryUserID.Name = [System.String]'lblPrimaryUserID'
$lblPrimaryUserID.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblPrimaryUserID.TabIndex = 3
$lblPrimaryUserID.Text = 'PrimaryUserID'
$lblPrimaryUserID.UseCompatibleTextRendering = $true
#
# txtPrimaryUserID
#
$txtPrimaryUserID.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]40))
$txtPrimaryUserID.Name = [System.String]'txtPrimaryUserID'
$txtPrimaryUserID.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtPrimaryUserID.TabIndex = 4
$txtPrimaryUserID.text = "corp\<userid>"
#
# lblInstallerID
#
$lblInstallerID.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]70))
$lblInstallerID.Name = [System.String]'lblInstallerID'
$lblInstallerID.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblInstallerID.TabIndex = 5
$lblInstallerID.Text = 'InstallerID'
$lblInstallerID.UseCompatibleTextRendering = $true
#
# txtInstallerID
#
$txtInstallerID.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]70))
$txtInstallerID.Name = [System.String]'txtInstallerID'
$txtInstallerID.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtInstallerID.TabIndex = 6
$txtInstallerID.Text = "corp\<userid>"
#
# lblGroupName
#
$lblGroupName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]100))
$lblGroupName.Name = [System.String]'lblGroupName'
$lblGroupName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblGroupName.TabIndex = 7
$lblGroupName.Text = 'GroupName'
$lblGroupName.UseCompatibleTextRendering = $true
#
# txtGroupName
#
$txtGroupName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]100))
$txtGroupName.Name = [System.String]'txtGroupName'
$txtGroupName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtGroupName.TabIndex = 8
$txtGroupName.Text = 'win'
#
# lblPackage
#
$lblPackage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]130))
$lblPackage.Name = [System.String]'lblPackage'
$lblPackage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblPackage.TabIndex = 9
$lblPackage.Text = 'Package'
$lblPackage.UseCompatibleTextRendering = $true
#
# txtPackage
#
$txtPackage.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]130))
$txtPackage.Name = [System.String]'txtPackage'
$txtPackage.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtPackage.TabIndex = 10
$txtPackage.Text = 'Engineering.ppkg'
#
# lblUnattendXML
#
$lblUnattendXML.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]160))
$lblUnattendXML.Name = [System.String]'lblUnattendXML'
$lblUnattendXML.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$lblUnattendXML.TabIndex = 11
$lblUnattendXML.Text = 'UnattendXML'
$lblUnattendXML.UseCompatibleTextRendering = $true
#
# txtUnattendXML
#
$txtUnattendXML.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]120,[System.Int32]160))
$txtUnattendXML.Name = [System.String]'txtUnattendXML'
$txtUnattendXML.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]200,[System.Int32]23))
$txtUnattendXML.TabIndex = 12
$txtUnattendXML.text = 'Unattend.xml'
#
# btn
#
$btn.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]220,[System.Int32]190))
$btn.Name = [System.String]'btn'
$btn.Padding = (New-Object -TypeName System.Windows.Forms.Padding -ArgumentList @([System.Int32]3))
$btn.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]100,[System.Int32]23))
$btn.TabIndex = 13
$btn.Text = 'Ok'
$btn.UseVisualStyleBackColor = $true
$btn.add_Click($btn_Click)
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]380,[System.Int32]290))
$Form1.Controls.Add($lblHostname)
$Form1.Controls.Add($txtHostname)
$Form1.Controls.Add($lblPrimaryUserID)
$Form1.Controls.Add($txtPrimaryUserID)
$Form1.Controls.Add($lblInstallerID)
$Form1.Controls.Add($txtInstallerID)
$Form1.Controls.Add($lblGroupName)
$Form1.Controls.Add($txtGroupName)
$Form1.Controls.Add($lblPackage)
$Form1.Controls.Add($txtPackage)
$Form1.Controls.Add($lblUnattendXML)
$Form1.Controls.Add($txtUnattendXML)
$Form1.Controls.Add($btn)
$Form1.Text = [System.String]'Pre-ProvisioningUI 1.0'
$Form1.ResumeLayout($true)


Add-Member -InputObject $Form1 -Name btn -Value $btn -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblHostname -Value $lblHostname -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtHostname -Value $txtHostname -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblPrimaryUserID -Value $lblPrimaryUserID -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtPrimaryUserID -Value $txtPrimaryUserID -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblInstallerID -Value $lblInstallerID -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtInstallerID -Value $txtInstallerID -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblGroupName -Value $lblGroupName -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtGroupName -Value $txtGroupName -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblPackage -Value $lblPackage -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtPackage -Value $txtPackage -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name lblUnattendXML -Value $lblUnattendXML -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name txtUnattendXML -Value $txtUnattendXML -MemberType NoteProperty
}
. InitializeComponent
