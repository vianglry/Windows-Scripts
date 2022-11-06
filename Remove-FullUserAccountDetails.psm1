
function New-ProfileListRegKeyBackup {
    $ProfileListBackupFolder = "C:\ProfileList.reg"
    $ProfileListRegKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"

    reg export $ProfileListRegKey $ProfileListBackupFolder
}


function Get-LocalUserRegistryKey {
    param (
        [ValidateNotNullOrEmpty()]
        [String]
        $UserAccounttobeRemoved
    )
    
    $ProfileListRegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*"
    Get-Itemproperty $ProfileListRegKey -name ProfileImagePath | `
        Where-Object -property ProfileImagePath -Like ("*" + $UserAccounttobeRemoved)
} 



function Remove-FullUserAccountDetails {
    param (
        [string]
        $UserAccount
    )
    New-ProfileListRegKeyBackup 

    $FUllUserRegistryKey = Get-LocalUserRegistryKey $UserAccount
    $LocalUserRegistryKeytobeRemoved = $FullUserRegistryKey.pspath 
    $LocalUserFiletobeRemoved = $FullUserRegistryKey.ProfileImagePath

    Remove-LocalUser $UserAccount
    Remove-Item $LocalUserFiletobeRemoved -Force -Recurse
    Remove-Item $LocalUserRegistryKeytobeRemoved
    }
