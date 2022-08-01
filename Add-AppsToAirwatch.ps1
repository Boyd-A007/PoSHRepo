[CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$AWServer,

        [Parameter(Mandatory=$True)]
        [string]$userName,

        [Parameter(Mandatory=$True)]
        [string]$password,

        [Parameter(Mandatory=$True)]
        [string]$tenantAPIKey,

        [Parameter(Mandatory=$True)]
        [string]$groupID
)

#region 
### Script Variables ####
$OutputFolder = "$($PSScriptRoot)\App-Injection-Output"
#endregion

Write-Verbose "-- Command Line Parameters --"
Write-Verbose ("UserName: " + $userName)
Write-Verbose ("Password: " + $password)
Write-Verbose ("Tenant API Key: " + $tenantAPIKey)
Write-Verbose ("Endpoint URL: " + $groupID)
Write-Verbose ("Working Directory: " + $OutputFolder)
Write-Verbose "-----------------------------"
Write-Verbose ""

function Get-AppsFromReport {
    Write-Log "Showing UI for CSV selection"
    $csv = Get-ChildItem -Path $OutputFolder -Filter "*.csv" | Select-Object Name, FullName | Out-GridView -OutputMode Single -Title "Select App CSV to Export"
    
    Write-Log "Fetching details from csv at $($csv.FullName)"
    $apps = Import-Csv -Path $csv.FullName

    Write-Log "Retrieved $($apps.count) Apps from csv"

    return $apps
}

function Initialize {
    Param(
        $OutputFolder
    )

    Write-Host "Initializing"

    Write-Log "Checking if $($OutputFolder) exists"
    if(!$(Test-Path -Path $OutputFolder)) {
        Write-Log "Creating $($OutputFolder)"
        New-Item -Path $OutputFolder -ItemType "Directory" | Out-Null
    }
}


function Write-Log {
    Param(
        [Parameter(Mandatory=$True)]
        [string]$logString
    )

    $logDate = Get-Date -UFormat "%y-%m-%d"
    $dateTime = (Get-Date).toString()
    $logPath = "$($OutputFolder)\Logs"

    if(!(Test-Path -Path $logPath)) { New-Item -Path $logPath -ItemType Directory | Out-Null }

    $logFile = "$($logPath)\log-$($logDate).txt"
    "$($dateTime) | $($logString)" | Out-File -FilePath $logFile -Append
}

#region AirWatch API
<#
  This method maps all the AirWatch Properties extracked and stored in a table to the corresponding JSON value in the AirWatch
  API body.
#>
Function Map-AppDetailsJSON {

    Param(
		[Parameter(Mandatory=$True)]
		$appDetails
	)

    $appDetails | Add-Member -MemberType NoteProperty -Name "DeviceType" -Value 12
    $appDetails | Add-Member -MemberType NoteProperty -Name "SupportedModels" -Value @{
        Model = @(@{
            ModelId = 83
            ModelName = "Desktop"
        })
    }
<#
#    # Setup DeviceType and SupportedModels based on AW Version
#    if ([System.Version]$appDetails.AirWatchVersion -ge [System.Version]"9.2.0.0") {
#        Write-Log -logString "AirWatch version $($appDetails.AirWatchVersion) is greater than 9.2, using Modelname Desktop"
#        $appDetails | Add-Member -MemberType NoteProperty -Name "DeviceType" -Value 12
#        $appDetails | Add-Member -MemberType NoteProperty -Name "SupportedModels" -Value @{
#            Model = @(@{
#                ModelId = 83
#                ModelName = "Desktop"
#            })
#        }
#    }
#    else {
#        Write-Log -logString "AirWatch version $($appDetails.AirWatchVersion) is less than 9.2, using Modelname Windows 10"
#        $appDetails | Add-Member -MemberType NoteProperty -Name "DeviceType" -Value 12
#        $appDetails | Add-Member -MemberType NoteProperty -Name "SupportedModels" -Value @{
#            Model = @(@{
#                ModelId = 50
#                ModelName = "Windows 10"
#            })
#        }
#    }
#>

    # Map all table values to the AirWatch JSON format
    $applicationProperties = @{
        ApplicationName = $appDetails.ApplicationName
	    AutoUpdateVersion = 'true'
	    BlobId = $appDetails.BlobID
	    DeploymentOptions = @{
		    WhenToInstall = @{
			    DiskSpaceRequiredInKb = 1
			    DevicePowerRequired= 2
			    RamRequiredInMb= 3
		    }
		    HowToInstall= @{
			    AdminPrivileges = "true"
			    DeviceRestart = "DoNotRestart"
			    InstallCommand = $appDetails.InstallCommand
			    InstallContext = $appDetails.InstallContext
			    InstallTimeoutInMinutes = $appDetails.InstallTimeoutInMinutes
			    InstallerRebootExitCode = $appDetails.InstallerRebootExitCode
			    InstallerSuccessExitCode = $appDetails.InstallerSuccessExitCode
			    RetryCount = 3
			    RetryIntervalInMinutes = 5
		    }
		    WhenToCallInstallComplete = @{
			    UseAdditionalCriteria = "false"
			    IdentifyApplicationBy = "DefiningCriteria"
                CriteriaList = @(@{
                    CriteriaType = "AppExists"
				    LogicalCondition = "End"
                    AppCriteria = @{
                        ApplicationIdentifier = $appDetails.InstallApplicationIdentifier
                        VersionCondition = "Any"
                    }
                })
			    CustomScript = @{
				    ScriptType = "Unknown"
				    CommandToRunTheScript = "Text value"
				    CustomScriptFileBlodId = 3
				    SuccessExitCode = 1
			    }
		    }
	    }
	    FilesOptions = @{
		    ApplicationUnInstallProcess = @{
			    UseCustomScript = "true"
			    CustomScript =  @{
				    CustomScriptType = "Input"
				    UninstallCommand = $appDetails.UninstallCommandLine
			    }
		    }
	    }
	    Description = $appDetails.Description
	    Developer = $appDetails.Developer
	    DeveloperEmail = ""
	    DeveloperPhone = ""
	    DeviceType = $appDetails.DeviceType
	    EnableProvisioning = "false"
	    FileName = $appDetails.UploadFileName
	    IsDependencyFile = "false"
	    LocationGroupId = $appDetails.LocationGroupId
	    MsiDeploymentParamModel = @{
		    CommandLineArguments = $appDetails.InstallCommand
		    InstallTimeoutInMinutes = $appDetails.InstallTimeoutInMinutes
		    RetryCount = 3
		    RetryIntervalInMinutes = 5
	    }
	    PushMode = 0
	    SupportEmail = ""
	    SupportPhone = ""
	    SupportedModels = $appDetails.SupportedModels
	    SupportedProcessorArchitecture = "x86"
    }

    $json = $applicationProperties | ConvertTo-Json -Depth 10
    Write-Verbose "------- JSON to Post---------"
    Write-Verbose $json
    Write-Verbose "-----------------------------"
    Write-Verbose ""

    Return $json
}

<#
  This implementation uses Basic authentication.  See "Client side" at https://en.wikipedia.org/wiki/Basic_access_authentication for a description
  of this implementation.
#>
Function Create-BasicAuthHeader {

	Param(
		[Parameter(Mandatory=$True)]
		[string]$username,
		[Parameter(Mandatory=$True)]
		[string]$password)

	$combined = $username + ":" + $password
	$encoding = [System.Text.Encoding]::ASCII.GetBytes($combined)
	$encodedString = [Convert]::ToBase64String($encoding)

	Return "Basic " + $encodedString
}

<#
  This method builds the headers for the REST API calls being made to the AirWatch Server.
#>
Function Create-Headers {

    Param(
		[Parameter(Mandatory=$True)]
		[string]$authString,
		[Parameter(Mandatory=$True)]
		[string]$tenantCode,
		[Parameter(Mandatory=$True)]
        [string]$acceptType,
		[Parameter(Mandatory=$True)]
		[string]$contentType
    )


    $header = @{"Authorization" = $authString; "aw-tenant-code" = $tenantCode; "Accept" = $acceptType.ToString(); "Content-Type" = $contentType.ToString()}

    Return $header
}

<#
    This Function uploads the app file to the AirWatch server
#>
Function Upload-Blob {
  Param(
	  [Parameter(Mandatory=$True)]
	  [String] $airwatchServer,
	  [Parameter(Mandatory=$True)]
      [String] $filename,
	  [Parameter(Mandatory=$True)]
      [String] $filePath,
	  [Parameter(Mandatory=$True)]
      [String] $groupID,
	  [Parameter(Mandatory=$True)]
      [hashtable] $headers
  )

  $url = Create-BlobURL -baseURL $airwatchServer -filename $filename -groupID $groupID

  Write-Verbose "File Path $filePath"

  Write-Verbose "URL: $($url.ToString())"

  $response = Invoke-RestMethod -Method Post -Uri $url.ToString() -Headers $headers -InFile $filePath

  Write-Verbose "Response 'Upload Blob' :: $response"

  Return $response
}

<#
  Creates the url for the blob upload
#>
Function Create-BlobURL {
    Param(
		[Parameter(Mandatory=$True)]
		[String] $baseURL,
		[Parameter(Mandatory=$True)]
        [String] $filename,
		[Parameter(Mandatory=$True)]
        [String] $groupID
	)
    $url = "$baseURL/api/mam/blobs/uploadblob?filename=$filename&organizationgroupid=$groupID"

    Return $url
}

Function Save-App {
	Param(
		[Parameter(Mandatory=$True)]
		[String] $awServer,
		[Parameter(Mandatory=$True)]
		[hashtable] $headers,
		[Parameter(Mandatory=$True)]
		$appDetails
	)

	$url = "$awServer/api/v1/mam/apps/internal/begininstall"

    try {
        $response = Invoke-RestMethod -Method Post -Uri $url.ToString() -Headers $headers -Body $appDetails
    } catch {
         Write-Verbose -Message "Save app failed :: $PSItem"
    }


    Write-Verbose "Response 'Save App' :: $response"

	Return $response
}

function Get-AirWatchVersion {
    Param(
        [Parameter(Mandatory=$True)]
        [hashtable] $headers
    )
    
    try {
        $endpoint = "$awServer/api/system/info"
	    $response = Invoke-RestMethod -Method Get -Uri $endpoint.ToString() -Headers $headers
        $version = $response.ProductVersion

    }
    catch [System.Net.WebException] {
        $response = $_.Exception.Response | ConvertTo-Json
        Write-Verbose "Querying AirWatch version ($endpoint) Failed! Exception :: $($_.Exception.Message)"
        Write-Verbose "RESPONSE :: $($_.Exception.Response | ConvertTo-Json)"
    } 
    catch {
        $response = $null
        Write-Verbose "Get AirWatch Version failed :: $PSItem"
    }

    Write-Verbose "Get AirWatch Version response :: $response"
    return $version;
}
#endregion

function Get-AppsFromReport {
    Write-Log "Showing UI for CSV selection"
    $csv = Get-ChildItem -Path $OutputFolder -Filter "*.csv" | Select-Object Name, FullName | Out-GridView -OutputMode Single -Title "Select App CSV to Export"
    
    Write-Log "Fetching details from csv at $($csv.FullName)"
    $apps = Import-Csv -Path $csv.FullName

    Write-Log "Retrieved $($apps.count) Apps from csv"

    return $apps
}

  function Add-AppsToAirWatch {
    # Setup API Info
    #Setup header information
    $restUserName = Create-BasicAuthHeader -username $userName -password $password
    $useJSON = "application/json"
    
    #Build Headers for APIs
    $headers = Create-Headers -authString $restUserName `
        -tenantCode $tenantAPIKey `
        -acceptType $useJson `
        -contentType "multipart/form-data"

    $headers

    #Retrieve AW version
#    $airwatchVersion = Get-AirWatchVersion -headers $headers
#    Write-Log "AirWatch version is $($airWatchVersion)"

    #Get Apps
    $apps = Get-AppsFromReport
    #Loop Through Apps
    foreach($app in $apps) {
        Write-Host "Exporting $($app.ApplicationName)"
        
        # Add additional properties
        $app | Add-Member -MemberType NoteProperty -Name "AirWatchVersion" -Value $airwatchVersion
        
        # Fetch App filename and path
        $uploadFileName = $app.UploadFileName
        $networkFilePath = "Microsoft.Powershell.Core\FileSystem::$($app.FilePath)"
        
        # Upload Blob
        if(Test-Path $networkFilePath) {
            $blobUploadResponse = Upload-Blob -airwatchServer $AWServer `
               -filename $uploadFileName `
        	    -filepath $networkFilePath `
        	    -groupID $groupID `
                -headers $headers

            # Extract Blob ID and store in the properties table.
            $blobID = [string]$blobUploadResponse.Value
            $app.BlobId = $blobID

            # Map App details to Json
            $awJson = Map-AppDetailsJson -appDetails $app

            # Save App
            if($app.BlobId -ne $null) {
                # Save App/Finish Upload in AirWatch
               $webReturn = Save-App -awServer $AWServer `
                   -headers $headers `
                   -appDetails $awJson

               Write-Verbose -Message "Return from save $webReturn"
           } else {
               Write-Verbose -Message "Blob ID not in hashtable, unable to finish upload of  $($app.ApplicationName)"
           }

        } else {
            Write-Output "Unable to reach app file path, $($app.ApplicationName) not uploaded to AirWatch"
        }
     
    }
    
}
  
Write-Host "Adding Apps to AirWatch"
Write-Log -logString "Adding Apps to AirWatch"
Add-AppsToAirWatch
