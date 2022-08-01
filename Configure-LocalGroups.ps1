param([switch] $reset)

 

function Generate-RandomString{

    param([int] $len)

 

    $seed=$NULL;for($a=48;$a –le 122;$a++) {$seed+=,[char][byte]$a }

    for($x = 1; $x -le $len; $x++){

        $randstring+=($seed | Get-Random)

    }

 

    return $randstring;

}

 

function Write-Status{

    param([int] $id, [string] $message, [string] $type = "info")

 

    "Status: $Message"

 

    switch ($type)

    {

        'info' { Write-EventLog -LogName System -Source "Device Provisioning" -EntryType Information -EventID $id -Message $message }

        'error' { Write-EventLog -LogName System -Source "Device Provisioning" -EntryType Error -EventID $id -Message $message }

        'warn' { Write-EventLog -LogName System -Source "Device Provisioning" -EntryType Warning -EventID $id -Message $message }

        Default { Write-EventLog -LogName System -Source "Device Provisioning" -EntryType Information -EventID $id -Message $message }

    }

}

 

$LogPath = "$env:PROGRAMDATA\Bank of America\Log"

$LogFile = "Configure-LocalUser-$(Get-Date -UFormat "%Y%m%d-%H%M%S").log"

?(!(Test-Path -Path $LogPath)){ni $LogPath -Force -ItemType Directory}

Start-Transcript -Path "$LogPath\$LogFile"

New-EventLog -LogName System -Source "Device Provisioning" -ErrorAction SilentlyContinue

Write-Status -id 1 -message "Starting Configure-LocalUser.ps1. Logging to $LogPath\$LogFile"

 

$RealAdmin = Get-LocalUser | where{$_.SID -like "*-500"}

$RealGuest = Get-LocalUser | where{$_.SID -like "*-501"}

 

if($reset -eq $false){

 

    "Configuring admin account"

    try{

        Enable-LocalUser -SID $($RealAdmin.SID)

        Rename-LocalUser -SID $($RealAdmin.SID) -NewName "nbe1www"

        Set-LocalUser -SID $($RealAdmin.SID) -Password $(ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -ErrorAction Stop

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

 

        Get-LocalUser -SID $($RealAdmin.SID) | FL

       

    if( ( Get-LocalUser -SID $($RealAdmin.SID) ).Enabled -eq "True"){

        #Clear out the local admin group

        "Cleaning local administrators group"

        $Admins = Get-LocalGroupMember -Group Administrators | Where{ ($_.PrincipalSource -eq "Local") -and ($_.SID -notlike "*-500") }

        ForEach($User in $Admins){

            "Removing $($User.Name) from Administrators"

            try{ Remove-LocalGroupMember -Group Administrators -Member $User.Name }

            catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

           

            ($_.SID).Value | out-file "$env:SystemRoot\Panther\OUsers.dat" -Append

        }

    }else{ Write-Status -message "Removing the user from the admin group before a local admin is enabled is a bad idea" -id 2 -type warn }

   

    "Configuring guest account"

    try{

        $RealGuest | Rename-LocalUser -NewName "nbeqss0"

        $RealGuest | Set-LocalUser `

        -Password $(ConvertTo-SecureString -String $( Generate-RandomString -len 24 ) -AsPlainText -Force) `

        -PasswordNeverExpires $true `

        -UserMayChangePassword $false

        $RealGuest | Disable-LocalUser

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

 

 

    "Creating dummy admin"

    try{

        New-LocalUser -Name Administrator `

        -Password $(ConvertTo-SecureString -String $( Generate-RandomString -len 24 ) -AsPlainText -Force) `

        -FullName "System Administrators" -Description "Account for System Administration" `

        -Disabled  | Add-LocalGroupMember -Group "Guests" | Out-Null

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

}

 

if($reset){

    "Reversing User Account Configuration"

 

    "Adding users back to the local administrators group"

    if(Test-Path -Path "$env:SYSTEMROOT\Panther\OUsers.dat"){

        $OUsers = GC -Path "$env:SYSTEMROOT\Panther\OUsers.dat"

        foreach($User in $OUsers){ Get-LocalUser -SID $User | Add-LocalGroupMember -Group "Administrators" }

        Remove-Item -Path "$env:SYSTEMROOT\Panther\OUsers.dat" -Force

    }

 

    "Deleting dummy admin"

    try{ Remove-LocalUser -Name Administrator `

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

 

   "Resetting local admin account"

    try{

        Disable-LocalUser -SID $($RealAdmin.SID)

        Rename-LocalUser -SID $($RealAdmin.SID) -NewName "Administrator"

        Set-LocalUser -SID $($RealAdmin.SID) -Password $(ConvertTo-SecureString -String "P@ssw0rd" -AsPlainText -Force) -ErrorAction Stop

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }

 

 

    "Resetting local guest account"

     try{

        $RealGuest | Rename-LocalUser -NewName "Guest"

        $RealGuest | Set-LocalUser `

        -Password $(ConvertTo-SecureString -String $( Generate-RandomString -len 24 ) -AsPlainText -Force) `

        -PasswordNeverExpires $true `

        -UserMayChangePassword $true

        $RealGuest | Disable-LocalUser

    }catch [System.Exception]{ Write-Status -message $_ -id 2 -type error }      

}

 

 

Stop-Transcript