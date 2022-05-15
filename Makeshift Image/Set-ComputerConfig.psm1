
Enable-CompanyLocalAdmin

Set-CompanyComputerPassword

Set-CompanyComputerName

Set-CompanyComputerConfig
    #Enable DEP 
    #Turn off hibernate
    #Set the computer to stay on while the installations happen
    #Install programs

Restart-Computer

Remove-TempAdminAccount

Connect-companyDomain