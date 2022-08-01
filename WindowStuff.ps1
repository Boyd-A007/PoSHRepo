function Set-WindowProperties{
    param{
        [string] $windowtitle,
        [int] $height,
        [int] $width
    }

    $pshost = get-host
    $pswindow = $pshost.ui.rawui
    $newsize = $pswindow.buffersize
    $newsize.height = $height
    $newsize.width = $width
    $pswindow.buffersize = $newsize

    $newsize = $pswindow.windowsize
    $newsize.height = $height
    $newsize.width = $width
    $pswindow.windowsize = $newsize
    $pswindow.windowtitle = $Title
}

function Get-ScreenResolution {            
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")            
    [void] [Reflection.Assembly]::LoadWithPartialName("System.Drawing")            
    $Screens = [system.windows.forms.screen]::AllScreens            

    foreach ($Screen in $Screens) {            
    $DeviceName = $Screen.DeviceName            
    $Width  = $Screen.Bounds.Width            
    $Height  = $Screen.Bounds.Height            
    $IsPrimary = $Screen.Primary            

    $OutputObj = New-Object -TypeName PSobject             
    $OutputObj | Add-Member -MemberType NoteProperty -Name DeviceName -Value $DeviceName            
    $OutputObj | Add-Member -MemberType NoteProperty -Name Width -Value $Width            
    $OutputObj | Add-Member -MemberType NoteProperty -Name Height -Value $Height            
    $OutputObj | Add-Member -MemberType NoteProperty -Name IsPrimaryMonitor -Value $IsPrimary            
    $OutputObj            

    }            
}