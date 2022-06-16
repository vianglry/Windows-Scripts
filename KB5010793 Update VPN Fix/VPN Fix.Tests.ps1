BeforeAll {
    
    ."C:\Users\Ron\code stuff\PowerShell\Windows-Scripts\Merge.ps1"

}
Describe "KB5010793 VPN Fix
Determines your windows build number then contacts the Windows update server and to pull down the proper 
version of update kb5010793. The possible downloads are as follows: 
Win10 build 19042/19043/19044 - KB5010793
win11 - kb5010795" {
    Context "Test Group 1:
    Get-WindowsBuildNumber" {

        IT "Test 1.1:
        Gets your current windows build" {

            $FunctionBuildNumber = Get-WindowsBuildNumber

            $Test_buildNumber = Get-CimInstance Win32_OperatingSystem | Select-Object -Property buildnumber

            $Test_buildNumber.buildnumber.equals($FunctionBuildNumber.buildnumber) | Should -Be $true
        }
    }
    Context "Test Group 2:
    Test-VPNFixExistence - Compares the supplied windows build number to the hashmap of supported Windows builds." {
        IT "Test 2.1:
        Check to see if the function returns 'False' when the the build number is not in the hashmap" {

            $winBuildNumber = 55

            $IsThisbuildnumberInTheHash = Test-VPNFixExistence $winBuildNumber

            $IsThisbuildnumberInTheHash | should -be $false


        }

        IT "Test 2.2:
        Check to see if the function returns 'True' when the the build number is in the hashmap." {


            $MicrosoftVPNFix_WebaddressToLocalDestinationMap.Keys.ForEach( {Test-VPNFixExistence $_ | should -be $true})

        }
    }

    Context "Test Group 3:  IGNORE FOR NOW                                                    
    Install-VPNFix - Runs the .exe file saved in '$VPNFixFileLocation'" {       #No idea how to make this work right now

        BeforeEach {
            
            $DummyExe = "testdrive:\test.exe"
            Mock Install-VPNFix -Verifiable {$VPNFixFileLocation -eq $DummyExe}
            Mock Invoke-Expression {return {$true}} -ParameterFilter {($Command -eq '& "testdrive:\test.exe"')}
        }

        IT "Test 3.1:
        Tests to see if Install-VPNFix makes a call to the .exe file saved in the folder specified" {


            
            Create-Object| Should Be  $true

        }
    }
}
