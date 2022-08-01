param($OSDisk, $RemoveRules)

#Use Dism to dump the AppxPackages
"Retrieving AppX-Package List from $OSDisk"
&DISM.exe /Image:$OSDisk /Get-ProvisionedAppxPackages > $env:temp\AppxPackages.txt
$LASTEXITCODE

#Read in the AppX Packages we don't want
$remove = Get-Content $RemoveRules

#Read back the AppXPackages file and get the package names out of it
$packages = Select-String -path $env:temp\AppxPackages.txt -pattern "PackageName : "

foreach($package in $packages.line){
    $package = $package.ToString().Split(":")[1].Trim()

    foreach($def in $remove){
        if($package -match $def){ 
            #Now use DISM to remove the AppXPackages we don't want    
            "Removing $package from $OSDisk"
            &dism /Image:$OSDisk /Remove-ProvisionedAppxPackage /PackageName:$package
            $LASTERROR
         }
    }
}



