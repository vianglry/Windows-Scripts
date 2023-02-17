$UpperCaseLetters           = (65..90) | % {[char]$_}
$LowerCaseLetters           = (97..122) | % {[char]$_}
$SpecialCharactersString    = "!#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
$Numbers                    = "123456789"

function New-PasswordCharArray {
    Param (
        [string]$UpperCaseSet,
        [string]$LowerCaseSet,
        [string]$SpecialCharactersSet
    )    
    $ValidPasswordCharSet = -join ($UpperCaseSet + $LowerCaseSet +  $SpecialCharactersSet)
    $ValidPasswordCharSet
}

function Test-PasswordComposition {
    param (
        [string]$PasswordString,
        [parameter(Mandatory)]
        [array]$CharArray
    )
    $CharSetCheck = $CharArray | % { $PasswordString.Contains("$_")}
    $ContainsAtLeast1CharFromSet = $CharSetCheck.Contains($true)
    $ContainsAtLeast1CharFromSet
}

function Test-Password {
    param (
        [string]$GeneratedPassword,
        [string]$CharArray1,
        [string]$CharArray2,
        [string]$CharArray3
    )
    $ListofCharArrays = ($CharArray1, $CharArray2, $CharArray3)
    
    foreach ($array in $ListofCharArrays) {
    
        Test-PasswordComposition -PasswordString $GeneratedPassword -CharArray $array
    }

}

function New-RandomPassword {
    param (
        [Parameter(Mandatory)]
        [ValidateScript( { $_ -ge 12 -or $(throw [System.ArgumentException]"length must be at least 12") } )]
        [int] $length
    )

    #$PasswordCharSet = -join ($UpperCaseLetters + $LowerCaseLetters +  $SpecialCharactersString)
    $PasswordCharSetArray = $PasswordCharSet.ToCharArray()
    
    $PasswordArray = $PasswordCharSetArray | Get-Random -count $length | % {[char]$_}

    $PasswordArray

    -join ($Password)
}
