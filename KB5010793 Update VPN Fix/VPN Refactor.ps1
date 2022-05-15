$Win10_19042_20H2x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win10_19043_21H1x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win10_19044_21H2x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win11_22000x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"

$UpdateFile = "C:\VPNFix"

$Win10_19042_20H2x64_location = $UpdateFile + "windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win10_19043_21H1x64_location = $UpdateFile + "windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win10_19044_21H2x64_location = $UpdateFile + "windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$Win11_22000x64_location = $UpdateFile + "windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"


function Get-WindowsBuildNumber {
  
    Get-CimInstance Win32_OperatingSystem | Select-Object -Property buildnumber
    
}

function Download-File {
    Param (
        [string]$URL,
        [String]$Location
    )

    $Winbuild = Get-WindowsBuildNumber
    Write-host "Windows Build "$winbuild.buildnumber" found. Starting Download."
    Start-Sleep 5
    Invoke-WebRequest -Uri $URL -OutFile $Location -v
    Write-host "Download Complete"
    Start-Sleep 5
}

function Download-VPNFix {

    $winbuild = Get-WindowsBuildNumber

    if ($winbuild.buildnumber -eq 19042){

        Download-File -URL $Win10_19042_20H2x64_Address  -Location $Win10_19042_20H2x64_location
        
    }
    elseif ($winbuild.buildnumber -eq 19043){

        Download-File -URL $Win10_19043_21H1x64_Address -Location $Win10_19043_21H1x64_location

    }
    elseif ($winbuild.buildnumber -eq 19044){
        
        Download-File -URL $Win10_19044_21H2x64_Address -Location $Win10_19044_21H2x64_location
        
    }
    elseif ($winbuild.buildnumber -eq 22000){
        
        Download-File -URL $Win11_22000x64_Address -Location $Win11_22000x64_location
        
    }

    Start-Sleep 5
}

function Install-VPNFix {
    param (
        [string]$VPNFixFileLocation
    )
    
    Write-host "Starting the Install"

    wusa.exe $VPNFixFileLocation /q /warnrestart
    
}



Download-VPNFix

$VPNFile = Get-ChildItem $UpdateFile

Install-VPNFix -VPNFixFileLocation $VPNFile