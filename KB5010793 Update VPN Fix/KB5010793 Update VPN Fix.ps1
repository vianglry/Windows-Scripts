$win10Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$win10Location = "windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
$updateFile = "C:\VPNFix"

$addressToLocationMap = @{
    19042 = @{address=$win10Address; location=(Join-Path -Path $updateFile -ChildPath $win10Location)} # this hash table could be its own variable to avoid duplicating it for the next 2 build numbers.
    19043 = @{address=$win10Address; location=(Join-Path -Path $updateFile -ChildPath $win10Location)}
    19044 = @{address=$win10Address; location=(Join-Path -Path $updateFile -ChildPath $win10Location)}
    22000 = @{
      address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
      location = Join-Path -Path $updateFile -ChildPath "windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
    }
}

function Get-VPNFix {
    $winBuildNumber = (Get-WindowsBuildNumber).buildnumber
    if ($addressToLocationMap.HasKey($winBuildNumber)) {
        $VPNFix = $addressToLocationMap[$winBuildNumber]
        DownLoad-File -URL $VPNFix.address -Location $VPNFix.location
    } else {
        Write-Host "This build does not have a VPN fix."
        return
    }
    Start-Sleep 5
}


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

function Install-VPNFix {
    param (
        [string]$VPNFixFileLocation
    )
    
    Write-host "Starting the Install"

    wusa.exe $VPNFixFileLocation /q /warnrestart
    
}


Download-VPNFix

$VPNFile = Get-ChildItem $UpdateFile

Install-VPNFix -VPNFixFileLocation $VPNFile.FullName
