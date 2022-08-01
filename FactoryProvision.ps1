#------------------------------------------------------------------------
# Source File Information (DO NOT MODIFY)
# Source ID: f5539b2a-5b84-429a-9b0f-0273c560f6a8
# Source File: Factory Provisioning Tool.psproj
#------------------------------------------------------------------------
#region Project Recovery Data (DO NOT MODIFY)
<#RecoveryData:
XQIAAB+LCAAAAAAABACFUstugzAQvEfKP1g+ViIQEvJQiQ9VRJVDHwpRr5UhS3BrbGRMGvr1NZhU
idqql7XH3p3RjB1uIZVHUM2aakqGA4TCZyXfINUobkSaKynYJ+xXOKK8AtwdRoxrUCt8Myqr8W1b
C7vs7TI+FbzbZF2tTLUnOfBypE8ad0JG6gVUxaQg/mgcumfQ3xkV2KxJFgSTZeJTJ0gWU2fqL6mz
TLzM8fz5JA1mXjaji9Dtm/vR3sGuKYF4oXsJz+SS740cci/Vqh70EN3VjBvnHiaxpkrXZWvGav3V
ieKcqjaunapNWlvIQIFIIapFqo25Fd6Io3wH557LhPJXExYmdl+1yf3D/gtfnMsP54EyEUlVGL4M
kzNqX+CK0AJr8zsWi54UOzBBedvwSAsgEU21VA0yXUfWvgsTB7STkhvW0kyG7o+R4SB0r77TF58i
E2ddAgAA#>
#endregion
<#
    .NOTES
    --------------------------------------------------------------------------------
     Code generated by:  SAPIEN Technologies, Inc., PowerShell Studio 2018 v5.5.155
     Generated on:       10/23/2018 4:45 PM
     Generated by:       Brooks Peppin | www.brookspeppin.com | @brookspeppin
     Organization:       VMware, Inc.
    --------------------------------------------------------------------------------
    .DESCRIPTION
        Script generated by PowerShell Studio 2018
#>



#region Source: Startup.pss
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
YQAAAB+LCAAAAAAABACzCUpNzi9LLap0SSxJVAAyijPz82yVjPUMlex4uRQUbPyLMtMz8xJz3DJz
Uv0Sc1PtgksSi0pKC/QKiott9DFkebls9JGNtAMAoyFkEGEAAAA=#>
#endregion
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
              
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
              $ConsoleOutput (Type: System.Collections.ArrayList)
#>
       Param ([String]$Commandline)
              
       #--------------------------------------------------------------------------
       #TODO: Add initialization script here (Load modules and check requirements)
       Stop-Process -name sysprep -ErrorAction SilentlyContinue
       
       #--------------------------------------------------------------------------
       
       if((Show-MainForm_psf) -eq 'OK')
       {
              
       }
       
       $script:ExitCode = 0 #Set the exit code for the Packager
}


#endregion Source: Startup.pss

#region Source: Globals.ps1
       #--------------------------------------------
       # Declare Global Variables and Functions here
       #--------------------------------------------
       
       
       #Sample function that provides the location of the script
       function Get-ScriptDirectory
       {
       <#
              .SYNOPSIS
                     Get-ScriptDirectory returns the proper location of the script.
       
              .OUTPUTS
                     System.String
              
              .NOTES
                     Returns the correct path within a packaged executable.
       #>
              [OutputType([string])]
              param ()
              if ($null -ne $hostinvocation)
              {
                     Split-Path $hostinvocation.MyCommand.path
              }
              else
              {
                     Split-Path $script:MyInvocation.MyCommand.Path
              }
       }
       
       #Sample variable that provides the location of the script
       [string]$ScriptDirectory = Get-ScriptDirectory
       
       
       
#endregion Source: Globals.ps1

#region Source: MainForm.psf
function Show-MainForm_psf
{
#region File Recovery Data (DO NOT MODIFY)
<#RecoveryData:
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#>
#endregion
       #----------------------------------------------
       #region Import the Assemblies
       #----------------------------------------------
       [void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
       [void][reflection.assembly]::Load('System.Design, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
       [void][reflection.assembly]::Load('System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
       #endregion Import Assemblies

       #----------------------------------------------
       #region Generated Form Objects
       #----------------------------------------------
       [System.Windows.Forms.Application]::EnableVisualStyles()
       $formWorkspaceONEFactoryP = New-Object 'System.Windows.Forms.Form'
       $labelV15 = New-Object 'System.Windows.Forms.Label'
       $buttonApplyPPKGOnly = New-Object 'System.Windows.Forms.Button'
       $buttonBrowse2 = New-Object 'System.Windows.Forms.Button'
       $textboxXML = New-Object 'System.Windows.Forms.TextBox'
       $label2SelectConfiguration = New-Object 'System.Windows.Forms.Label'
       $statusbar1 = New-Object 'System.Windows.Forms.StatusBar'
       $buttonApplyPPKGXMLAndSyspr = New-Object 'System.Windows.Forms.Button'
       $label1SelectPPKG = New-Object 'System.Windows.Forms.Label'
       $buttonBrowse = New-Object 'System.Windows.Forms.Button'
       $textboxPPKG = New-Object 'System.Windows.Forms.TextBox'
       $menustrip1 = New-Object 'System.Windows.Forms.MenuStrip'
       $openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
       $openfiledialog2 = New-Object 'System.Windows.Forms.OpenFileDialog'
       $aboutToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
       $aboutToolStripMenuItem1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
       $documentationToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
       $InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
       #endregion Generated Form Objects

       #----------------------------------------------
       # User Generated Script
       #----------------------------------------------
       
       $formWorkspaceONEFactoryP_Load={
              #TODO: Initialize Form Controls here
              
       }
       
       $buttonBrowse_Click={
       
              if($openfiledialog1.ShowDialog() -eq 'OK')
              {
                     $textboxPPKG.Text = $openfiledialog1.FileName
              }
       }
       $buttonBrowse2_Click = {
              
              if ($openfiledialog2.ShowDialog() -eq 'OK')
              {
                     $textboxXML.Text = $openfiledialog2.FileName
              }
       }
       $buttonApplyPPKGOnly_Click = {
              if (-not $textboxPPKG.Text)
              {
                     [System.Windows.Forms.MessageBox]::Show('Please Select valid PPKG', 'Invalid Input')
                     Write-Status 'Please Select valid PPKG'
                     return
              }
              else
              {
                     #Applying PPKG
                     #$text = $textboxPPKG.Text
                     
                     Write-Status "Installing PPKG..."
                     #Install-ProvisioningPackage -PackagePath $textboxPPKG.Text -ForceInstall -QuietInstall
                     Add-ProvisioningPackage -PackagePath $textboxPPKG.Text -ForceInstall -QuietInstall
                     Status-Check
              }
              
       
              
              
       }
       
       $buttonApplyPPKGXMLAndSyspr_Click = {
              
              if (-not $textboxPPKG.Text)
              {
                     [System.Windows.Forms.MessageBox]::Show('Please Select valid PPKG', 'Invalid Input')
                     Write-Status 'Please Select valid PPKG'
                     Return
              }
              else
              {
                     $ppkg = $true
              }
              if (-not $textboxXML.Text)
              {
                     [System.Windows.Forms.MessageBox]::Show('Please Select valid XML', 'Invalid Input')
                     Write-Status 'Please Select valid XML'
                     Return
              }
              else
              {
                     $XML = $true
              }
              if ($ppkg -eq $true -and $XML -eq $true)
              {
                     
                     Write-Status "Downloading Workspace ONE App..."
                     $WS1_Path = "C:\Program Files (x86)\AirWatch\AgentUI\Resources\Bundle"
                     #$WS1_URL = "https://artifactory.air-watch.com/artifactory/ws1-esr-aw/3.2.34.0/AirWatchLLC.VMwareWorkspaceONE.zip"
                     if (!(Test-Path $WS1_Path))
                     {
                           md $WS1_Path
                     }
                     try
                     {
                           Invoke-WebRequest -OutFile ($WS1_Path + "\AirWatchLLC.VMwareWorkspaceONE.zip") -Uri "https://prod.esr.vmwservices.com/esr/services/api/platforms/windowspc/oems/any/apps/com.airwatch.workspaceoneunifiedagentbundle/latest?osVersion=10.0.10586" -Headers @{ "Accept" = "application/vnd.vmware.esr.get-latest-app-update-v1+json" }
                     }
                     catch
                     {
                           Write-Status $_.Exception
                           #Write-Status "Unable to download Workspace ONE App. Please check your internet connection and try again."
                           return
                     }
                     Write-Status "Downloading Workspace ONE Agent..."
                     if (!(Test-Path "C:\Recovery\OEM\"))
                     {
                           md "C:\Recovery\OEM\"
                     }
                     try
                     {
                           Invoke-WebRequest "https://awagent.com/Home/DownloadWinPcAgentApplication" -outfile "C:\Recovery\OEM\AirwatchAgent.msi"
                     }
                     Catch
                     {
                           Write-Status $_.Exception
                           #Write-Status "Unable to download Workspace ONE Agent. Please check your internet connection and try again."
                           return
                     }
                     
                     #Applying PPKG
                     #$text = $textboxPPKG.Text
                     $labelLog.Visible = $true
                     Write-Status "Installing PPKG..."
                     Install-ProvisioningPackage -PackagePath $textboxPPKG.Text -ForceInstall -QuietInstall
                     Status-Check
                     $path = $textboxXML.Text
                     Copy-Item -Path $path -Destination c:\windows\panther\ -Force
                     Remove-Item -Path $path -Force
                     
                     Stop-Process -name sysprep
                     Write-Status "Staging PPKG for recovery..."
                     #xcopy Content\AirWatchLLC.VMwareWorkspaceONE.zip c:\Recovery\customizations\ /f /y
                     Write-Status "Sysprepping with XML...System will reboot automatically."
                     c:\windows\system32\sysprep\sysprep.exe /generalize /reboot /oobe
              }
       
              
       }
       
       
       
       function Write-Status
       {
              
              [CmdletBinding()]
              param
              (
                     [parameter(Mandatory = $true)]
                     [ValidateNotNullOrEmpty()]
                     [string]$Message
              )
              $statusbar1.Text = $Message
       }
       
       
       
       
       function Status-Check
       {
              <# 
        .Description
           1. StausCheck script V1.3
           2. Script will print "Status Check Script Version 1.1"
           3. App installation is synchronous process
           3. Script will keep looping until timeout occurs or until all apps are not installed 
           4. Script will generate log file inside a C:\Dell  
           5. Application(s) that are in progress, there is no status code for those application.
           6. Application(s) that requires reboot will terminate the script with status code 2 and log it
           7. Application(s) that fails will terminate the script with exit code 1
           8. All Application(s) installation, script exit with exit code 0
              9. Timer back in.  Accept command line argument for time to use in minutes from Dell wrapper.  If timeout occurs will terminate with exit code 3
       
       .Synopsis
         Monitor app installation status and log into log file.
       
       .Parameter None  
       
       #>
              
              
              param (
                     [string]$LogFileName = "PpkgInstallerLog.txt",
                     [string]$LogDirectory = "$env:HOMEDRIVE\Dell",
                     [int32]$Timeout = 90
              )
              $scriptver = "1.3.1"
              
              Function Log
              {
                     [cmdletbinding()]
                     Param (
                           [parameter(ValueFromPipeline)]
                           [string]$Message
                     )
                     
                     $DateTime = Get-Date -Format "MM-dd-yy HH:mm:ss"
                     Add-Content -Value "$DateTime : $Message"  "$LogDirectory\$LogFileName"
              }
              
              function Test-RegistryValue
              {
                     param (
                           [parameter(Mandatory = $true)]
                           [ValidateNotNullOrEmpty()]
                           $Path,
                           [parameter(Mandatory = $true)]
                           [ValidateNotNullOrEmpty()]
                           $Value
                     )
                     
                     try
                     {
                           Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
                           return $true
                     }
                     catch
                     {
                           return $false
                     }
              }
              
              try
              {
                     
                     
                     If (!(test-path $LogDirectory))
                     {
                           New-Item -ItemType Directory -Force -Path $LogDirectory
                     }
                     
                     "Status Check Script Version 1.3" | Log
                     
                     [System.Collections.ArrayList]$inProgress = @();
                     $serviceAccountPath = "HKLM:\SOFTWARE\AirWatchMDM\AppDeploymentAgent\S-1-5-18"
                     $appManifestPath = "HKLM:\SOFTWARE\AirWatchMDM\AppDeploymentAgent\AppManifests"
                     $Queue = "HKLM:\SOFTWARE\AirWatchMDM\AppDeploymentAgent\Queue\*"
                     
                     if (Get-Item $Queue -ErrorAction Ignore)
                     {
                           $task = Get-ScheduledTask -TaskName "Software Distribution Queue Task"
                           
                           if ($task.State -eq "Queued")
                           {
                                  SCHTASKS /Run /TN "\VMware\AirWatch\Software Distribution Queue Task" /I
                           }
                     }
                     
                     Write-Status "Waiting for application installation to begin..."
                     start-sleep 2
                     Write-Status "App install log located at: C:\Dell\PpkgInstallerLog.txt"
                     "Waiting 10 seconds for $serviceAccountPath to filled up..." | Log
                     Start-Sleep 10
                     
                     
                     $appList = @{ }
                     
                     $timer = [Diagnostics.Stopwatch]::StartNew()
                     $index = 0;
                     $appCount = (Get-ChildItem -Path "$env:ProgramData\AirWatchMDM\AppDeploymentCache").Count
                     
                     Write-Status "Application timeout value is $Timeout minutes."
                     "Wait for app installs, current timeout value is $Timeout minutes" | Log
                     
                     while ($appCount -gt 0)
                     {
                           
                           foreach ($appGuid in (Get-ChildItem -Path $serviceAccountPath -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Name))
                           {
                                  $appGuidindex = $appGuid.LastIndexOf("\")
                                  
                                  $len = $appGuid.Length
                                  
                                  $guid = $appGuid.Substring($appGuidindex + 1, $len - ($appGuidindex + 1))
                                  
                                  $path = "$serviceAccountPath\$guid"
                                  
                                  
                                  
                                  if (Test-RegistryValue -Path $appManifestPath\$guid -Value "Name")
                                  {
                                         $name = (Get-ItemProperty $appManifestPath\$guid -Name Name).Name
                                  }
                                  
                                  #check app installation status
                                  if (Test-Path $path)
                                  {
                                         #$path | Log
                                         $isInstalled = (Get-ItemProperty $path -Name IsInstalled).IsInstalled
                                         
                                         if (Test-RegistryValue -Path $path -Value "LastStatusCode")
                                         {
                                                $Status = "0x" + "{0:x}" -f (Get-ItemProperty $path -Name LastStatusCode).LastStatusCode
                                                
                                                if ($appList.ContainsKey($appGuid)) { continue }
                                                
                                                if (($Status -shr 12) -eq 0xfffC0000) #Reboot
                                                {
                                                       $message = "$appGuid : $name  : $Status  : Reboot Required"
                                                       $message | Log
                                                       Write-Status "$name  : $Status  : Reboot Required"
                                                       #[System.Environment]::Exit(2)
                                                }
                                                elseIf ($isInstalled -eq "true") #check if app installed
                                                {
                                                       $message = "$appGuid  : $name : $Status  : Installed"
                                                       Write-Status "$name  : $Status  : Installed"
                                                       $message | Log
                                                       $appList.Add($appGuid, $true)
                                                       $appCount--;
                                                }
                                                elseIf (($Status -band 0x40000000) -eq 0x40000000) #check if app failed
                                                {
                                                       $message = "$appGuid : $name : $Status  : Failed"
                                                       Write-Status "$name  : $Status  : Failed"
                                                       $message | Log
                                                       $appCount--;
                                                       throw $message
                                                }
                                                elseIf (($Status -shr 12) -eq 0x00000000) #check if app deployment in progress(queued) 
                                                {
                                                       $message = "$appGuid : $name  : $Status  : Queued"
                                                       Write-Status "$name  : $Status  : Queued"
                                                       $message | Log
                                                       
                                                }
                                         }
                                         else
                                         {
                                                #LastStatusCode key doesn't exist it means App installation is InProgress 
                                                
                                                $message = "$appGuid : $name : App installation is running"
                                                Start-Sleep -Seconds 1
                                                Write-Status "$name  : $Status  : App installation is running"
                                                
                                                $message | Log
                                         }
                                  }
                                  else
                                  {
                                         "Path doesn't exist: $path" | Log
                                         Write-Status "Path doesn't exist: $path"
                                  }
                                  
                           }
                           
                           If ($timer.Elapsed.TotalMinutes -gt $Timeout)
                           {
                                  $currentruntime = $timer.Elapsed.Minutes
                                  Write-Status "Elapsed timer value: $currentruntime minutes. Timer exceeded, quitting."
                                  "Elapsed timer: $currentruntime minutes" | Log
                                  "Timer exceeded, exit app install loop" | Log
                                  break
                           }
                           Else
                           {
                                  $currentruntime = $timer.Elapsed.Minutes
                                  #Write-Status "Elapsed timer value: $currentruntime minutes"
                                  "Elapsed timer: $currentruntime minutes" | Log
                           }
                           Start-Sleep 10
                           
                     }
                     
                     if ($appCount -eq 0 -and ($timer.Elapsed.TotalMinutes -lt $Timeout))
                     {
                           Write-Status "All Applications Installed Successfully"
                           "All Applications Installed Successfully" | Log
                           [System.Windows.Forms.MessageBox]::Show('All Applications Installed Successfully', 'Success')
                           
                           #[System.Environment]::Exit(0)
                     }
                     else
                     {
                           "Application install timed out, exit error code 3" | Log
                           Write-Status "Application install timed out, exit error code 3"
                           [System.Windows.Forms.MessageBox]::Show('Application install timed out, exit error code 3', 'Timeout')
                           
                           [System.Environment]::Exit(3)
                     }
              }
              Catch
              {
                     # Log any errors accumulated in the script
                     if ($Error.Count -gt 0)
                     {
                           $Error | Log
                           Write-Status $Error
                     }
                     [System.Windows.Forms.MessageBox]::Show("Application install failure: $error", 'Failure')
                     Start-Process notepad.exe -ArgumentList "C:\Dell\PpkgInstallerLog.txt"
                     
                     
                     [System.Environment]::Exit(1)
              }
              
       }
       
       
       $aboutToolStripMenuItem1_Click={
              #TODO: Place custom script here
              [System.Windows.Forms.MessageBox]::Show("Script Version Info:`nVersion 1.5.0.0 - Oct-16-18`nAuthor: Brooks Peppin`n@brookspeppin`nwww.brookspeppin.com`nbpeppin@vmware.com`n", "About", [System.Windows.Forms.MessageBoxButtons]::OKCancel, [System.Windows.Forms.MessageBoxIcon]::Question)
              
       }
       
       
       
       $documentationToolStripMenuItem_Click={
              #TODO: Place custom script here
              Start-Process "https://docs.vmware.com/en/VMware-Workspace-ONE-UEM/9.7/vmware-airwatch-guides-97/GUID-AW97-DellProvisioning.html"
       }
       
       
       $OpenLog_Click={
              #TODO: Place custom script here
              Start-Process notepad -ArgumentList C:\Dell\PpkgInstallerLog.txt
       }
       
       # --End User Generated Script--
       #----------------------------------------------
       #region Generated Events
       #----------------------------------------------
       
       $Form_StateCorrection_Load=
       {
              #Correct the initial state of the form to prevent the .Net maximized form issue
              $formWorkspaceONEFactoryP.WindowState = $InitialFormWindowState
       }
       
       $Form_StoreValues_Closing=
       {
              #Store the control values
              $script:MainForm_textboxXML = $textboxXML.Text
              $script:MainForm_textboxPPKG = $textboxPPKG.Text
       }

       
       $Form_Cleanup_FormClosed=
       {
              #Remove all event handlers from the controls
              try
              {
                     $buttonApplyPPKGOnly.remove_Click($buttonApplyPPKGOnly_Click)
                     $buttonBrowse2.remove_Click($buttonBrowse2_Click)
                     $buttonApplyPPKGXMLAndSyspr.remove_Click($buttonApplyPPKGXMLAndSyspr_Click)
                     $buttonBrowse.remove_Click($buttonBrowse_Click)
                     $formWorkspaceONEFactoryP.remove_Load($formWorkspaceONEFactoryP_Load)
                     $aboutToolStripMenuItem1.remove_Click($aboutToolStripMenuItem1_Click)
                     $documentationToolStripMenuItem.remove_Click($documentationToolStripMenuItem_Click)
                     $formWorkspaceONEFactoryP.remove_Load($Form_StateCorrection_Load)
                     $formWorkspaceONEFactoryP.remove_Closing($Form_StoreValues_Closing)
                     $formWorkspaceONEFactoryP.remove_FormClosed($Form_Cleanup_FormClosed)
              }
              catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
       }
       #endregion Generated Events

       #----------------------------------------------
       #region Generated Form Code
       #----------------------------------------------
       $formWorkspaceONEFactoryP.SuspendLayout()
       $menustrip1.SuspendLayout()
       #
       # formWorkspaceONEFactoryP
       #
       $formWorkspaceONEFactoryP.Controls.Add($labelV15)
       $formWorkspaceONEFactoryP.Controls.Add($buttonApplyPPKGOnly)
       $formWorkspaceONEFactoryP.Controls.Add($buttonBrowse2)
       $formWorkspaceONEFactoryP.Controls.Add($textboxXML)
       $formWorkspaceONEFactoryP.Controls.Add($label2SelectConfiguration)
       $formWorkspaceONEFactoryP.Controls.Add($statusbar1)
       $formWorkspaceONEFactoryP.Controls.Add($buttonApplyPPKGXMLAndSyspr)
       $formWorkspaceONEFactoryP.Controls.Add($label1SelectPPKG)
       $formWorkspaceONEFactoryP.Controls.Add($buttonBrowse)
       $formWorkspaceONEFactoryP.Controls.Add($textboxPPKG)
       $formWorkspaceONEFactoryP.Controls.Add($menustrip1)
       $formWorkspaceONEFactoryP.AutoScaleDimensions = '16, 31'
       $formWorkspaceONEFactoryP.AutoScaleMode = 'Font'
       $formWorkspaceONEFactoryP.ClientSize = '949, 570'
       $formWorkspaceONEFactoryP.MainMenuStrip = $menustrip1
       $formWorkspaceONEFactoryP.Margin = '16, 14, 16, 14'
       $formWorkspaceONEFactoryP.Name = 'formWorkspaceONEFactoryP'
       $formWorkspaceONEFactoryP.ShowIcon = $False
       $formWorkspaceONEFactoryP.Text = 'Workspace ONE Factory Provisioning Tool'
       $formWorkspaceONEFactoryP.add_Load($formWorkspaceONEFactoryP_Load)
       #
       # labelV15
       #
       $labelV15.AutoSize = $True
       $labelV15.Location = '861, 473'
       $labelV15.Margin = '8, 0, 8, 0'
       $labelV15.Name = 'labelV15'
       $labelV15.Size = '71, 38'
       $labelV15.TabIndex = 9
       $labelV15.Text = 'v 1.5'
       $labelV15.UseCompatibleTextRendering = $True
       #
       # buttonApplyPPKGOnly
       #
       $buttonApplyPPKGOnly.Location = '256, 358'
       $buttonApplyPPKGOnly.Margin = '7, 7, 7, 7'
       $buttonApplyPPKGOnly.Name = 'buttonApplyPPKGOnly'
       $buttonApplyPPKGOnly.Size = '487, 55'
       $buttonApplyPPKGOnly.TabIndex = 8
       $buttonApplyPPKGOnly.Text = 'Apply PPKG Only'
       $buttonApplyPPKGOnly.UseCompatibleTextRendering = $True
       $buttonApplyPPKGOnly.UseVisualStyleBackColor = $True
       $buttonApplyPPKGOnly.add_Click($buttonApplyPPKGOnly_Click)
       #
       # buttonBrowse2
       #
       $buttonBrowse2.Location = '773, 262'
       $buttonBrowse2.Margin = '7, 7, 7, 7'
       $buttonBrowse2.Name = 'buttonBrowse2'
       $buttonBrowse2.Size = '80, 55'
       $buttonBrowse2.TabIndex = 1
       $buttonBrowse2.Text = '...'
       $buttonBrowse2.UseCompatibleTextRendering = $True
       $buttonBrowse2.UseVisualStyleBackColor = $True
       $buttonBrowse2.add_Click($buttonBrowse2_Click)
       #
       # textboxXML
       #
       $textboxXML.AutoCompleteMode = 'SuggestAppend'
       $textboxXML.AutoCompleteSource = 'FileSystem'
       $textboxXML.Location = '149, 272'
       $textboxXML.Margin = '20, 17, 20, 17'
       $textboxXML.Name = 'textboxXML'
       $textboxXML.Size = '601, 39'
       $textboxXML.TabIndex = 0
       #
       # label2SelectConfiguration
       #
       $label2SelectConfiguration.AutoSize = $True
       $label2SelectConfiguration.Location = '149, 224'
       $label2SelectConfiguration.Margin = '20, 0, 20, 0'
       $label2SelectConfiguration.Name = 'label2SelectConfiguration'
       $label2SelectConfiguration.Size = '434, 38'
       $label2SelectConfiguration.TabIndex = 5
       $label2SelectConfiguration.Text = '2. Select Configuration File (XML)'
       $label2SelectConfiguration.UseCompatibleTextRendering = $True
       #
       # statusbar1
       #
       $statusbar1.Location = '0, 518'
       $statusbar1.Margin = '7, 7, 7, 7'
       $statusbar1.Name = 'statusbar1'
       $statusbar1.Size = '949, 52'
       $statusbar1.TabIndex = 4
       $statusbar1.Text = 'Please select PPKG and XML and click the button above.'
       #
       # buttonApplyPPKGXMLAndSyspr
       #
       $buttonApplyPPKGXMLAndSyspr.Location = '256, 427'
       $buttonApplyPPKGXMLAndSyspr.Margin = '7, 7, 7, 7'
       $buttonApplyPPKGXMLAndSyspr.Name = 'buttonApplyPPKGXMLAndSyspr'
       $buttonApplyPPKGXMLAndSyspr.Size = '487, 55'
       $buttonApplyPPKGXMLAndSyspr.TabIndex = 3
       $buttonApplyPPKGXMLAndSyspr.Text = 'Apply PPKG, XML and Sysprep'
       $buttonApplyPPKGXMLAndSyspr.UseCompatibleTextRendering = $True
       $buttonApplyPPKGXMLAndSyspr.UseVisualStyleBackColor = $True
       $buttonApplyPPKGXMLAndSyspr.add_Click($buttonApplyPPKGXMLAndSyspr_Click)
       #
       # label1SelectPPKG
       #
       $label1SelectPPKG.AutoSize = $True
       $label1SelectPPKG.Location = '146, 100'
       $label1SelectPPKG.Margin = '20, 0, 20, 0'
       $label1SelectPPKG.Name = 'label1SelectPPKG'
       $label1SelectPPKG.Size = '206, 38'
       $label1SelectPPKG.TabIndex = 2
       $label1SelectPPKG.Text = '1. Select PPKG'
       $label1SelectPPKG.UseCompatibleTextRendering = $True
       #
       # buttonBrowse
       #
       $buttonBrowse.Location = '770, 138'
       $buttonBrowse.Margin = '7, 7, 7, 7'
       $buttonBrowse.Name = 'buttonBrowse'
       $buttonBrowse.Size = '80, 55'
       $buttonBrowse.TabIndex = 1
       $buttonBrowse.Text = '...'
       $buttonBrowse.UseCompatibleTextRendering = $True
       $buttonBrowse.UseVisualStyleBackColor = $True
       $buttonBrowse.add_Click($buttonBrowse_Click)
       #
       # textboxPPKG
       #
       $textboxPPKG.AutoCompleteMode = 'SuggestAppend'
       $textboxPPKG.AutoCompleteSource = 'FileSystem'
       $textboxPPKG.Location = '146, 148'
       $textboxPPKG.Margin = '20, 17, 20, 17'
       $textboxPPKG.Name = 'textboxPPKG'
       $textboxPPKG.Size = '601, 39'
       $textboxPPKG.TabIndex = 0
       #
       # menustrip1
       #
       $menustrip1.ImageScalingSize = '32, 32'
       [void]$menustrip1.Items.Add($aboutToolStripMenuItem)
       $menustrip1.Location = '0, 0'
       $menustrip1.Name = 'menustrip1'
       $menustrip1.Padding = '16, 5, 0, 5'
       $menustrip1.Size = '949, 55'
       $menustrip1.TabIndex = 6
       $menustrip1.Text = 'menustrip1'
       #
       # openfiledialog1
       #
       $openfiledialog1.DefaultExt = 'txt'
       $openfiledialog1.Filter = 'All Files|*.*'
       $openfiledialog1.ShowHelp = $True
       #
       # openfiledialog2
       #
       $openfiledialog2.DefaultExt = 'xml'
       $openfiledialog2.Filter = 'All Files|*.*'
       $openfiledialog2.ShowHelp = $True
       #
       # aboutToolStripMenuItem
       #
       [void]$aboutToolStripMenuItem.DropDownItems.Add($aboutToolStripMenuItem1)
       [void]$aboutToolStripMenuItem.DropDownItems.Add($documentationToolStripMenuItem)
       $aboutToolStripMenuItem.Name = 'aboutToolStripMenuItem'
       $aboutToolStripMenuItem.Size = '92, 45'
       $aboutToolStripMenuItem.Text = 'Help'
       #
       # aboutToolStripMenuItem1
       #
       $aboutToolStripMenuItem1.Name = 'aboutToolStripMenuItem1'
       $aboutToolStripMenuItem1.Size = '338, 46'
       $aboutToolStripMenuItem1.Text = 'About'
       $aboutToolStripMenuItem1.add_Click($aboutToolStripMenuItem1_Click)
       #
       # documentationToolStripMenuItem
       #
       $documentationToolStripMenuItem.Name = 'documentationToolStripMenuItem'
       $documentationToolStripMenuItem.Size = '338, 46'
       $documentationToolStripMenuItem.Text = 'Documentation'
       $documentationToolStripMenuItem.add_Click($documentationToolStripMenuItem_Click)
       $menustrip1.ResumeLayout()
       $formWorkspaceONEFactoryP.ResumeLayout()
       #endregion Generated Form Code

       #----------------------------------------------

       #Save the initial state of the form
       $InitialFormWindowState = $formWorkspaceONEFactoryP.WindowState
       #Init the OnLoad event to correct the initial state of the form
       $formWorkspaceONEFactoryP.add_Load($Form_StateCorrection_Load)
       #Clean up the control events
       $formWorkspaceONEFactoryP.add_FormClosed($Form_Cleanup_FormClosed)
       #Store the control values when form is closing
       $formWorkspaceONEFactoryP.add_Closing($Form_StoreValues_Closing)
       #Show the Form
       return $formWorkspaceONEFactoryP.ShowDialog()

}
#endregion Source: MainForm.psf

#Start the application
Main ($CommandLine)
