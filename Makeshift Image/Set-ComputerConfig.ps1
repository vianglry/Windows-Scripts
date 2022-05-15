

##########################################################################################
#START THE COMPUTER AND PERFORM INITIAL SET UP
##########################################################################################


##########################################################################################
#SCRIPT 1 START
##########################################################################################


#!PS
#maxlength=100000
#timeout=10000

#Enable local administrator account
#Set password 
#change computer name to its service tag
#CONNECT COMPUTER TO THE DOMAIN



#For deleting the temp admin account
#Get the name of the account you're currently in and put it in a file at the root of C:
$Tempprof = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\S-1-5-21*"
New-Item -ItemType File -Path c:\ -Name "Temp Admin" -Value $tempprof.ProfileImagePath



#Enable local administrator account
#Set the Local Admin password
#change computer name to its service tag
$localpassword = ConvertTo-SecureString "<FIND A WAY TO GENERATE PWS>" -AsPlainText -Force
get-localuser "administrator" | Set-LocalUser -Password $Localpassword 
Enable-LocalUser 'administrator'

#change computer name to its service tag
$compname = Get-WmiObject win32_SystemEnclosure | Select-Object serialnumber
Rename-Computer -NewName $compname.serialnumber 



#Enable DEP 
bcdedit.exe /set "{current}" "nx" AlwaysOn



#Turn off hibernate
powercfg.exe /hibernate off



#Restart the comptuer
Restart-Computer -force

##########################################################################################
#SCRIPT 1 END
##########################################################################################


##########################################################################################
#LOG INTO DEFAULT ADMIN ACCOUNT
##########################################################################################


##########################################################################################
#TRANSFER CHROME_SETUP.EXE, DISPLAYLINK, AND MBAM TO THE CLIENT 
##########################################################################################


##########################################################################################
# Uninstall the Preinstalled versions of Office
##########################################################################################


##########################################################################################
# Change the ranking of Providers
#HKLM\SYSTEM\CurrentControlSet\Control\NetworkProvider
##########################################################################################


##########################################################################################
#SCRIPT 2 START
##########################################################################################


#!ps
#maxlength=100000
#timeout=2100000
#Set the computer to stay on while the installations happen
#Decrypt the C: Drive
#Delete the temp account and data created during setup
#Install Chrome 
#Install MBAM 
#Install Office365 apps
#Install Teams
#Set screen lock times
#Connect to the domamin



#Set the computer to stay on while the installations happen
#Set the computer to never go to sleep while plugged in 
Powercfg /Change standby-timeout-ac 0

#Set the computer to never go to sleep while on battery in
Powercfg /Change standby-timeout-dc 0



#Decrypt the C: Drive
Manage-bde C: -off



$Admincred = Get-Credential



#Delete the temp account and data created during setup
#Get the name of the Temp admin Account from the file created in the first script
$Acct = get-content -Path "C:\Temp Admin"
$tempuser = $acct.Split("\")
$prof = Get-Itemproperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*" -name ProfileImagePath
$remacct = $prof | Where-Object -property ProfileImagePath -Like ("*" + $Acct)

#Deletes the Account from the list of local users
#Remove-localuser $tempuser[2]
Add-Content -Path "C:\Temp Admin" -value ("1. remove " + $tempuser[2])

#Deletes the registry key for the account
#remove-item $remacct.PSPath -force
Add-Content -Path "C:\Temp Admin" -value ("2. remove " +  $remacct.PSPath)

#Deletes the user folder
#remove-item ("C:\Users\" + $tempuser[2]) -recurse -force
Add-Content -Path "C:\Temp Admin" -value ("3. remove C:\Users\" + $tempuser[2])

#Delete the user note
#remove-item "C:\Temp Admin" -force
Add-Content -Path "C:\Temp Admin" -value ("4. remove C:\Temp Admin")



#Install Chrome from the 
cd "<FILE PATH>"

.\ChromeSetup.exe

Start-Sleep 20



#Install DisplayLink 
cd "<FILE PATH>"

.\"DisplayLink USB Graphics Software for Windows 10.1 M0.exe"

Start-Sleep 20



#Install MBAM 
#Install MbamClientSetup
cd "<FILE PATH>"

.\"1. MbamClientSetup-2.5.1100.0.msi"

Start-Sleep 30

#Install MBAM2.5-Client
.\"2. MBAM2.5-Client-KB4340040.msp" 

Start-Sleep 30



#Connect to the domamin
Add-Computer -DomainName YOURDOMAIN.local -Credential $Admincred

Restart-computer

##########################################################################################
#SCRIPT 2 END
##########################################################################################



