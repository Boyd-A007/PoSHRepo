[CmdletBinding()]
param (
    [string] $RootFolder = "$env:ProgramFiles\Bank of America",
    [string] $RootRegHive = "HKLM:\Software\Bank of America",
    [string] $LogFile = "$env:ProgramFiles\Bank of America\Log\Apply-AccountSetting.log",
    [string] $Utils = "C:\BAC\Util",
    [switch] $Reset
)

function Add-LogEntry{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string]
        $Message,
        [string]
        $Type = "INFO",
        [string]
        $LogFile = $script:LogFile
    )
    
    PROCESS {
        if(-not (Test-Path -Path $LogFile)){
            New-Item -ItemType File -Path $LogFile -Force | Out-Null
        }

        $time = (Get-Date -Format HH:mm:s) + ".000+000"
        $date = (Get-Date -Format MM-dd-yyyy)
        $LogEntry = "$date; $time; $type; $Message"
        
        Write-Output $LogEntry | Out-File -FilePath $LogFile -Encoding "Default" -Append
        if($type -like "*Err"){ $script:GlobalErrors++; Write-Host "ERR: $Message" -ForegroundColor Red }
        if($type -like "*Warn"){ $script:GlobalWarns++; Write-Host "WARN: $Message" -ForegroundColor Yellow }
        Write-Verbose $Message
    }
}

function New-RandomString{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [int]
        $Length
    )

    $s = $null
    for ($a = 48; $a -le 122; $a++){
        $s += [char][byte]$a
    }

    for ($x = 1; $x -le $Length; $x++) {
        $rstring += ($s | Get-Random)
    }

    return $rString
}

function Set-LocalAccount{
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $SID,
        [Parameter()]
        [string]
        $Name,
        [Parameter()]
        [securestring]
        $Password,
        [Parameter()]
        [ValidateSet('Enable', 'Disable')]
        $Status,
        [Parameter()]
        [bool]
        $PWNeverExpires,
        [Parameter()]
        [bool]
        $PWUserCanChange
    )

    try{
        Set-LocalUser -SID $SID `
        -Password $Password
        -PasswordNeverExpires $PWNeverExpires
        -UserMayChangePassword $PWUserCanChange
        -$Status
    }catch {
        Add-LogEntry -Type "Err" -Message "Error configuring acount"
        Add-LogEntry -Type "Exc" -Message $_.Exception.Message
        return $_.Exception.HResult
    }

<#
    if($Status -eq 'Enable'){
        try {
            Add-LogEntry "Enabling Account"
            Enable-LocalUser -SID $SID  
        }
        catch {
            Add-LogEntry -Type "Err" -Message "Error enabling acount"
            Add-LogEntry -Type "Exc" -Message $_.Exception.Message
            return $_.Exception.HResult
        }
    }else{
        try {
            Add-LogEntry "Enabling Account"
            Disable-LocalUser -SID $SID  
        }
        catch {
            Add-LogEntry -Type "Err" -Message "Error disabling acount"
            Add-LogEntry -Type "Exc" -Message $_.Exception.Message
            return $_.Exception.HResult
        }
    }
    #>
}

$DTStamp = Get-Date -Format yyyyddMMHHmm
$TrueAdmin = Get-LocalUser | Where-Object{$_.SID -like "*-500"}
$TrueGuest = Get-LocalUser | Where-Object{$_.SID -like "*-501"}

#Backup existing log file if found
if(Test-Path -Path $LogFile){
    Move-Item -Path $LogFile -Destination $($LogFile).Replace('.log', "_$DTStamp.Log")
}

Add-LogEntry "Configuring Local Accounts"

Add-LogEntry "Configuring $($TrueAdmin.Name)"
Set-LocalAccount -SID $($TrueAdmin.SID) -Name 'nbe1www' -Password $(ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText) -Status Enable -PWNeverExpires $true -PWUserCanChange $true

Add-LogEntry "Configuring $($TrueGuest.Name)"
Set-LocalAccount -SID $($TrueGuest.SID) -Name 'nbeqss0' -Password $(ConvertTo-SecureString -String $(New-RandomString -Length 24) -AsPlainText -Force) -Status Disable -PWNeverExpires $true -PWUserCanChange $false

Add-LogEntry "Configuring Administrator"
try{
    New-LocalUser -Name "Administrator" `
    -Password $(ConvertTo-SecureString -String $(New-RandomString -Length 24) -AsPlainText -Force)
    -FullName "System Administrator" -Description "Account for System Administration"
    -Disable | Add-LocalGroupMember -Group "Guests" | Out-Null
}catch{
    Add-LogEntry -Type "Err" -Message "Error configuring acount"
    Add-LogEntry -Type "Exc" -Message $_.Exception.Message
}

