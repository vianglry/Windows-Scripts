BeforeAll {
    $srcfile = get-childitem  *Remove-FullUserAccountDetails.ps1 -Recurse 
    . $srcfile.FullName 
}
Describe "Test for the existence the Test_User" {
    It "should return true" {
        $Username = "Test_User"
        $User = get-localuser $Username 
        $User.Name.equals($Username) | Should -Be $true
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