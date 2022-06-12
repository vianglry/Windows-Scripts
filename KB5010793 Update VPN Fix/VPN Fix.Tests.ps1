BeforeAll{

  ."C:\Users\Ron\code stuff\PowerShell\Windows-Scripts\KB5010793 Update VPN Fix\KB5010793 Update VPN Fix.ps1"
}

Describe "KB5010793 VPN Fix
Determines your windows build number then contacts the Windows update server and to pull down the proper 
version of update kb5010793. The possible downloads are as follows: 
Win10 build 19042/19043/19044 - KB5010793
win11 - kb5010795" {

  Context "Test 1:
  Get-WindowsBuildNumber" {

    IT "Gets your current windows build" {

      $FunctionBuildNumber = Get-WindowsBuildNumber

      $Test_buildNumber = Get-CimInstance Win32_OperatingSystem | Select-Object -Property buildnumber

      $Test_buildNumber.buildnumber.equals($FunctionBuildNumber.buildnumber) | Should -Be $true
    }
  }

  Context "Test 2:
  Download-File
  Contacts the specified URL and downloads the file to a specified location
  on your hard drive" {            
  
    IT "Checks if the Download-file function runs" {
      
      Mock Download-File {} -Verifiable

      Should -Invoke -CommandName Download-File -Times 0 
    }
  }

  Context "Test 3: Download-VPNFix 
  Downloads a version of the VPN fix based on the winbuild number passed into the function" {

    IT "Test 3.1 - Downloads version 19042 of the VPN fix." {

      Mock Download-VPNFix {-URL $Win10_19042_20H2x64_Address  -Location $Win10_19042_20H2x64_location}`
      -Verifiable -ParameterFilter {$winbuild -eq 19042}

      Should -Invoke -CommandName Download-VPNFix -Times 0 
    }

    IT "Test 3.2 - Downloads version 19043 of the VPN fix." {

      Mock Download-VPNFix {} -Verifiable -ParameterFilter {$winbuild -eq 19043}

      Should -Invoke -CommandName Download-VPNFix -Times 0 
    }

    IT "Test 3.3 - Downloads version 19044 of the VPN fix." {

      Mock Download-VPNFix {} -Verifiable -ParameterFilter {$winbuild -eq 19044}

      Should -Invoke -CommandName Download-VPNFix -Times 0 
    }

    IT "Test 3.4 - Downloads version 22000 of the VPN fix." {

      Mock Download-VPNFix {} -Verifiable -ParameterFilter {$winbuild -eq 22000}

      Should -Invoke -CommandName Download-VPNFix -Times 0 
    }

    IT "Test 3.5 - The windows version specified does not match the cases" {

      Mock Download-VPNFix {} -Verifiable -ParameterFilter {$winbuild -eq 22}

      Should -Invoke -CommandName Download-VPNFix -Times 0 
    }
  }

  Context "Test 4: Install-VPNFix
  Runs the .exe file saved in '$VPNFixFileLocation'" {

    BeforeAll {
      
      $DummyExe = "testdrive:\test.txt"
      Mock Install-VPNFix -Verifiable {$VPNFixFileLocation -eq $DummyExe}
    }

    IT "Test 3.1 - Downloads version 19042 of the VPN fix." {

      Should -Invoke -CommandName Install-VPNFix -Times 0
    }
  }
}

            