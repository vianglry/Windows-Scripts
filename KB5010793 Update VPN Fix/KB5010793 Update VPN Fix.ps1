$win10WebAddress = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"
$win10UpdateFileName = "windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
$updateFilePath = "C:\VPNFixfile"

$MicrosoftVPNFix_WebaddressToLocalDestinationMap = @{
    19042 = @{Webaddress=$win10WebAddress; Destination=(Join-Path -Path $updateFilePath -ChildPath $win10UpdateFileName)} # this hash table could be its own variable to avoid duplicating it for the next 2 build numbers.
    19043 = @{Webaddress=$win10WebAddress; Destination=(Join-Path -Path $updateFilePath -ChildPath $win10UpdateFileName)}
    19044 = @{Webaddress=$win10WebAddress; Destination=(Join-Path -Path $updateFilePath -ChildPath $win10UpdateFileName)}
    22000 = @{
      Webaddress = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
      Destination = Join-Path -Path $updateFilePath -ChildPath "windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"
    }
}

function Get-WindowsBuildNumber {
    Get-CimInstance Win32_OperatingSystem | Select-Object -Property buildnumber
    Write-host "Windows Build "$winbuild.buildnumber" found. Starting Download."
    Start-Sleep 2
}

function Test-VPNFixExistence {
    param (
        $winBuildNumber
    )

    $WinbuildKeyExists = $MicrosoftVPNFix_WebaddressToLocalDestinationMap.Keys -contains ($winBuildNumber)
    
    $WinbuildKeyExists  
} 

function Install-VPNFix {
    param (
        [string]$VPNFixFile
    )
    
    Write-host "Starting the Install"
    wusa.exe $VPNFixFile /q /warnrestart
}


If ($MyInvocation.InvocationName -ne ".") {

    $winBuildNumber = Get-WindowsBuildNumber 

    $VPNFixExists = Test-VPNFixExistence $winBuildNumber
    if($VPNFixExists -eq $false) {
        Write-Host "No VPN fix exists for this build of Windows. Exiting the script."
        Exit
    }
    Write-Host "A VPN fix exists for this build of Windows. Starting download and installation."
    Start-Sleep 1

    $VPNFixFileDetails = $MicrosoftVPNFix_WebaddressToLocalDestinationMap[$winBuildNumber]
    New-Item -Type Directory -Path $updateFilePath
    Invoke-WebRequest -Uri $VPNFixFileDetails.Webaddress -OutFile $VPNFixFileDetails.Destination
    Install-VPNFix -VPNFixFile  $VPNFixFileDetails.Destination
    Remove-item $updateFilePath -Confirm:$false
}
