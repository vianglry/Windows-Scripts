
#Browsers
$MicrosoftEdge = "microsoft-edge:"


                #Company Admin Websites

#User Account Creation and Admin
$WebApp1 = 'https://WebApp1.com/'
$WebApp2 = 'https://WebApp2.com/'
$WebApp3 = 'https://WebApp3.com'
$WebApp4 = 'https://WebApp4.com/'
$CompanySite = 'https:/CompanySite.com/'
$MarketingApp = 'https://MarketingApp.com/'
$SalesTeamApp1 = 'https://SalesApp1.com'
$SalesTeamApp2 = 'https://SalesApp2.com'
$PhoneSystem = 'https://PhoneSystem.com'

#System Administration
$ComputerMGMTApp1 = 'https://ComputerMGMTApp1.com/'
$ComputerMGMTApp2 = 'https://ComputerMGMTApp1.com/'
$TicketSystem = 'https://TicketSystem.com'
$CloudNetworkingMgmtConsole = 'https://CloudNetworkingMgmtConsole.com/'
$CloudVulnerabilityMGMT = 'https://CloudVulnerabilityMGMT.com/'
$CloudDirectoryMGMT = 'https://CloudDirectoryMGMT.com/'
$CloudServerMGMT = 'https://CloudServerMGMT.com/'

#Docs
$UserOnboardingDoc = 'https://sharepoint.com/UserOnboarding'
$UserOffboardingDoc = 'https://sharepoint.com/UserOffboarding'
$ComputerDecomissioning = 'https://sharepoint.com/ComputerDecomissioning'
$ComputerSetup = 'https://sharepoint.com/ComputerSetup'



                #Website Hashmaps

$BigBoySiteMap = @{
    'WebApp1' = $WebApp1;
    'WebApp2' = $WebApp2;
    'WebApp3' = $WebApp3;
    'WebApp4' = $WebApp4;
    'CompanySite' = $CompanySite;
    'MarketingApp' = $MarketingApp;
    'SalesTeamApp1' = $SalesTeamApp1;
    'SalesTeamApp2' = $SalesTeamApp2;
    'PhoneSystem' = $PhoneSystem;
    'ComputerMGMTApp1' = $ComputerMGMTApp1;
    'ComputerMGMTApp2' = $ComputerMGMTApp2;
    'TicketSystem' = $TicketSystem;
    'CloudNetworkingMgmtConsole' = $CloudNetworkingMgmtConsole;
    'CloudVulnerabilityMGMT' = $CloudVulnerabilityMGMT;
    'CloudDirectoryMGMT' = $CloudDirectoryMGMT;
    'ComputerSetupSOP' = $ComputerSetupSOP;
    'CloudServerMGMT' = $CloudServerMGMT;
    'UserOnboardingDoc' = $UserOnboardingDoc;
    'UserOffboardingDoc' = $UserOffboardingDoc;
    'ComputerDecomissioningSOP' = $ComputerDecomissioning;
    'ComputerSetup' = $ComputerSetup;
}

#Onboarding
$CompanyOnboardingSites = @{
    'TicketSystem' = $BigBoySiteMap.TicketSystem;
    'UserOnboardingDoc' = $BigBoySiteMap.UserOnboardingDoc;
    'WebApp1' = $BigBoySiteMap.WebApp1;
    'WebApp2' = $BigBoySiteMap.WebApp2;
    'WebApp3' = $BigBoySiteMap.WebApp3;
    'WebApp4' = $BigBoySiteMap.WebApp4;
    'CompanySite' = $BigBoySiteMap.CompanySite;
    'MarketingApp' = $BigBoySiteMap.MarketingApp;
    'SalesTeamApp1' = $BigBoySiteMap.SalesTeamApp1;
    'SalesTeamApp2' = $BigBoySiteMap.SalesTeamApp2;
    'PhoneSystem' = $BigBoySiteMap.PhoneSystem;
    'ComputerMGMTApp1' = $BigBoySiteMap.ComputerMGMTApp1;
    'CloudDirectoryMGMT' = $BigBoySiteMap.CloudDirectoryMGMT;
}

#Offboarding
$CompanyOffboardingSites = @{
    'TicketSystem' = $BigBoySiteMap.TicketSystem;
    'UserOffboardingDoc' = $BigBoySiteMap.UserOffboardingDoc;
    'WebApp1' = $BigBoySiteMap.WebApp1;
    'WebApp2' = $BigBoySiteMap.WebApp2;
    'WebApp3' = $BigBoySiteMap.WebApp3;
    'WebApp4' = $BigBoySiteMap.WebApp4;
    'CompanySite' = $BigBoySiteMap.CompanySite;
    'MarketingApp' = $BigBoySiteMap.MarketingApp;
    'SalesTeamApp1' = $BigBoySiteMap.SalesTeamApp1;
    'SalesTeamApp2' = $BigBoySiteMap.SalesTeamApp2;
    'PhoneSystem' = $BigBoySiteMap.PhoneSystem;
    'ComputerMGMTApp1' = $BigBoySiteMap.ComputerMGMTApp1;
    'CloudDirectoryMGMT' = $BigBoySiteMap.CloudDirectoryMGMT;
}

#Computer Setup
$ComputerSetupSites = @{
    'ComputerMGMTApp1' = $BigBoySiteMap.ComputerMGMTApp1;
    'ComputerMGMTApp2' = $BigBoySiteMap.ComputerMGMTApp2;
    'CloudDirectoryMGMT' = $BigBoySiteMap.CloudDirectoryMGMT;
    'CloudVulnerabilityMGMT' = $BigBoySiteMap.CloudVulnerabilityMGMT;
}

#Computer Decomissioning
$ComputerDecomissioning = @{
    'ComputerDecomissioningSOP' = $BigBoySiteMap.ComputerDecomissioningSOP;
    'ComputerMGMTApp1' = $BigBoySiteMap.ComputerMGMTApp1;
    'ComputerMGMTApp2' = $BigBoySiteMap.ComputerMGMTApp2;
    'CloudDirectoryMGMT' = $BigBoySiteMap.CloudDirectoryMGMT;
    'CloudVulnerabilityMGMT' = $BigBoySiteMap.CloudVulnerabilityMGMT;
}


                #Helper Functions

function Open-PWManager {
    Set-Location "C:\Program Files\PWManager\"
    .\PWManager.exe
}

function Open-WebsiteWithEdge {
    param (
        [hashtable]$SiteMap
    )
    $SiteMap.values | % {Start-Process ($MicrosoftEdge + $_)}
}


                #Main Functions

function Open-CompanyOnboardingSites {
    Open-WebsiteWithEdge $CompanyOnboardingSites
    Open-PWManager
}

function Open-CompanyOffboardingSites {
    Open-WebsiteWithEdge $CompanyOffboardingSites
    Open-PWManager
}

function Open-CompanyComputerSetupSites {
    Open-WebsiteWithEdge $ComputerSetupSites
    Open-PWManager
}

function Open-CompanyComputerDecomSites {
    Open-WebsiteWithEdge $ComputerDecomissioning
    Open-PWManager
}
