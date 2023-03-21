BeforeAll {
    . Windows-Scripts\Remove-User-Account\Remove-FullUserAccountDetails.ps1


    $Password = ConvertFrom-SecureString "password123!ABC" -asplaintext -force
    $Username = "Test_User"
    New-LocalUser -Name $Username -Password $Password
    $UserMissingError = "Test_User is missing. Ending test."

    $TestUser = Get-localuser $Username

    if ($TestUser.equals("Test_User") -eq $false) {
        write-host $UserMissingError
        exit
    }

}
Describe "Test for the existence of a registry backup" {
    Context "When the user exists" {
        It "should return true" {
            New-ProfileListRegKeyBackup
            Test-path -path "C:\ProfileList.reg" | Should -Be $true
        }
    }
}