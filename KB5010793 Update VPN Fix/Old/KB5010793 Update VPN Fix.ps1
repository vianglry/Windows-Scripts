
$Win10User = ((Get-WMIObject -ClassName Win32_ComputerSystem).Username).Split('\')[1]

#win10 19042
$Win10_19042_20H2x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"

$Win10_19042_20H2x64_location = "C:\users\$win10user\downloads\windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"

#win10 19043
$Win10_19043_21H1x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"

$Win10_19043_21H1x64_location = "C:\users\$win10user\downloads\windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"

#Win10 19044
$Win10_19044_21H2x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"

$Win10_19044_21H2x64_location = "C:\users\$win10user\downloads\windows10.0-kb5010793-x64_3bae2e811e2712bd1678a1b8d448b71a8e8c6292.msu"


#win11
$Win11_22000x64_Address = "http://download.windowsupdate.com/d/msdownload/update/software/updt/2022/01/windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"

$Win11_22000x64_location = "C:\users\$win10user\downloads\windows10.0-kb5010795-x64_7fd6ce84756ac03585cc012568979eb08cc6d583.msu"

$winbuild = Get-CimInstance Win32_OperatingSystem | select -Property buildnumber

if ($winbuild.buildnumber -eq 19042){


#win10 19042
Write-host "Windows 10 Build 19042 found. Starting Download."

Sleep 5

Invoke-WebRequest -Uri $Win10_19042_20H2x64_Address -OutFile $Win10_19042_20H2x64_location -v

Write-host "Download Complete"

Sleep 5
 
Write-host "Starting the Install"

wusa.exe $Win10_19042_20H2x64_location /q /warnrestart

}
elseif ($winbuild.buildnumber -eq 19043){


#win10 19043
Write-host "Windows 10 Build 19043 found. Starting Download."

Sleep 5

Invoke-WebRequest -Uri $Win10_19043_21H1x64_Address -OutFile $Win10_19043_21H1x64_location -v

Write-host "Download Complete"

Sleep 5
 
Write-host "Starting the Install"

wusa.exe $Win10_19043_21H1x64_location /q /warnrestart
}
elseif ($winbuild.buildnumber -eq 19044){


#win10 19044
Write-host "Windows 10 Build 19044 found. Starting Download."

}
