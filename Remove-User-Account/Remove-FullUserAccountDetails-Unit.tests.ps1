BeforeAll {
    $srcfile = get-childitem  *Remove-FullUserAccountDetails.ps1 -Recurse 
    . $srcfile.FullName 
}
Describe "Test for the existence the Test_User account" {
    It "should return true" {
        $Username = "Test_User"
        $User = get-localuser $Username 
        $User.Name.equals($Username) | Should -Be $true
    }
}
Describe "Testing the New-ProfileListRegKeyBackup function" {
    It "Should create a backup of the registry and place it at the root of the C drive this test should detect it's existence" {
        New-ProfileListRegKeyBackup
        Test-path -path "C:\ProfileList.reg" | Should -Be $true
    }
}
Describe "Testing the Get-LocalUserRegistryKey function" {
    It "should be able to find a the registry key for a user." {
       $GHATestUser = Get-LocalUserRegistryKey runneradmin 
       $GHATestUser.ProfileImagePath | Should -Be "C:\Users\runneradmin"
    }
}