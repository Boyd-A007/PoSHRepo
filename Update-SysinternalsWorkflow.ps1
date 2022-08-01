#requires -version 4.0

#https://gist.github.com/jdhitsolutions/f0415db6bc8dc6236fb3

<#
A PowerShell workflow to download Sysinternals tools from web to a local folder.

Last updated: February 15, 2016
version     : 2.0

Changelog:
 2.0
 Moved path validation to a sequence step
 If destination doesn't exist it will be created.
 Modified activities to make them compatible with PowerShell 3.0
 Added error handling for starting the Webclient service
 Tested and verified remote processing
 combined a few sequences to avoid scoping problems
 Added code to download a list of online files and then compare instead of trying to 
 get each file online individually and then compare.
 Tested remote installation
 Modified version requirement to v4 since I have no v3 clients left to test with

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************
#>

Workflow Update-SysInternals {


Param(
[Parameter(Position = 0,Mandatory,HelpMessage = "Enter a folder path")]
[Alias("Path")]
[string]$Destination
)

Sequence {
    #Validate path
    Write-Verbose -Message "Validating destination path $Destination"        
    if (Test-Path -Path $Destination) {

        Write-Verbose -Message "Destination $Destination already exists"
        
    } #if test-path
    else {
       
       #Create the folder
        Try {
            Write-Verbose -message "Creating $Destination"
            New-Item -Path $Destination -ItemType Directory -ErrorAction Stop
        }
        Catch {
            Write-Warning -Message "Failed to create $Destination. $($_.Exception.message)"
            #Can't create the folder so bail out
            Return
        }

    } #else
}

Sequence {
    #Verify there is webclient service installed
    Write-Verbose -Message "Verifying WebClient service is available"
    Try {
        $test = Get-Service -Name Webclient -ErrorAction Stop
    }
    Catch {
        Write-Warning "Could not find the WebClient service. Aborting."
        #Bail out
        Return
    }

}

Sequence {
    #start the WebClient service if it is not running
    Write-Verbose -message "Checking status of WebClient service"
    if ((Get-Service -name WebClient).Status -eq 'Stopped') {
         Write-Verbose -message "Starting WebClient"
         Try {
            Start-Service -name WebClient -ErrorAction Stop
            $workflow:Stopped = $True
         }
         Catch {
            Write-Warning "Failed to start WebClient service. $($_.exception.message)"
            #can't start service so bail out
            Return
         }
    }
    else {
        <#
         Define a variable to indicate service was already running
         so that we don't stop it. Making an assumption that the
         service is already running for a reason.
        #>
        Write-Verbose -Message "Service is already running"
        $Workflow:Stopped = $False
    }

    Write-Verbose -Message (Get-Service -Name WebClient | Out-String)
   
}

Sequence {

    #get current files in destination
    Write-Verbose -message "Getting current listing of files from $Destination"
    $current = Get-Childitem -Path $Destination -File
    
    Write-Verbose -message "Creating a list of online files"
    #dowload list of files
    $webfiles = Get-ChildItem -Path "\\live.sysinternals.com\tools" -file
    
    if (-NOT $webfiles) {
        Write-Warning "No webfiles found"
        #if no online files found something went wrong so bail out.
        RETURN
    }
       
    Write-Verbose -Message "Found $($webfiles.count) online files"   

    #download files in parallel groups of 8
    Write-Verbose -message "Updating Sysinternals tools from \\live.sysinternals.com\tools to $destination"
    foreach -parallel -throttle 8 ($file in $current) {
        #get the web version
        Write-Verbose -Message "Testing $($file.Name)"
        $online = $($webfiles).Where({$_.name -eq $file.name})
        #write-Verbose -message ($online | out-string)
        if ($online.LastWriteTime.date -gt $file.lastWriteTime.date) {
            Write-Verbose -Message "Copying $($online.fullname)"
            Copy-Item -Path $online.fullname -Destination $Destination -PassThru
        }

    } #foreach

    Write-Verbose -message "Testing for online files not in $destination"

    #test for files online but not in the destination and copy them
    #compare to current list and get a list of file names that are missing
    $names = Compare-Object -ReferenceObject $webfiles -DifferenceObject $current -Property Name | 
    Select-object -ExpandProperty Name
    foreach -parallel -throttle 8 ($file in $names) {
        Get-Item -path "\\live.sysinternals.com\tools\$file" | Copy-Item -Destination $Destination -PassThru
    }

    if ( $workflow:Stopped ) {
        Write-Verbose -message "Stopping web client"
        Stop-Service -name WebClient
    }

    Write-Verbose "Sysinternals Update Complete"
} 

} #end workflow
