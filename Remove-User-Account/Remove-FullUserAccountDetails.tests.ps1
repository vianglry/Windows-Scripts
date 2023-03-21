BeforeAll {
    $srcfile = get-childitem  *Remove-FullUserAccountDetails.ps1 -Recurse 
    . $srcfile.FullName 

    $Password = Convertto-SecureString "password123!ABC" -asplaintext -force
    $Username = "Test_User"
    New-LocalUser -Name $Username -Password $Password
    $UserMissingError = "Test_User is missing. Ending test."



}
Describe "Test for the existence the Test_User" {
    It "should return true" {
        $TestUser = Get-localuser $Username
        $TestUser.FullName.equals("Test_User") | Should -Be $true
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