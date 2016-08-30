##Parameters
$Domaininfo=Get-ADDomain
$DomNetBios=$Domaininfo.NetBIOSName
$upnsuffix = '@' + $DomNetBios + '.f5demo.net'
$a = 'auser' + $upnsuffix
$b = 'buser' + $upnsuffix
$c = 'cuser' + $upnsuffix
$d = 'duser' + $upnsuffix
$e = 'euser' + $upnsuffix

Import-Module ActiveDirectory; 
new-aduser -givenname "Alpha" -surname "User" -name "Alpha User" -samaccountname "auser" -displayname "Alpha User" -enabled $true -UserPrincipalName $a -changepasswordatlogon $false -accountpassword (ConvertTo-SecureString "F5testnet" -AsPlainText -force) -PasswordNeverExpires $True -PassThru;
new-aduser -givenname "Beta" -surname "User" -name "Beta User" -samaccountname "buser" -displayname "Beta User" -enabled $true -UserPrincipalName $b -changepasswordatlogon $false -accountpassword (ConvertTo-SecureString "F5testnet" -AsPlainText -force) -PasswordNeverExpires $True -PassThru;
new-aduser -givenname "Charlie" -surname "User" -name "Charlie User" -samaccountname "cuser" -displayname "Charlie User" -enabled $true -UserPrincipalNamee $c -changepasswordatlogon $false -accountpassword (ConvertTo-SecureString "F5testnet" -AsPlainText -force) -PasswordNeverExpires $True -PassThru; 
new-aduser -givenname "Delta" -surname "User" -name "Delta User" -samaccountname "duser" -displayname "Delta User" -enabled $true -UserPrincipalName $d -changepasswordatlogon $false -accountpassword (ConvertTo-SecureString "F5testnet" -AsPlainText -force) -PasswordNeverExpires $True -PassThru;
new-aduser -givenname "Edward" -surname "User" -name "Edward User" -samaccountname "euser" -displayname "Edward User" -enabled $true -UserPrincipalName $e -changepasswordatlogon $false -accountpassword (ConvertTo-SecureString "F5testnet" -AsPlainText -force) -PasswordNeverExpires $True -PassThru;
netsh advfirewall set allprofiles state off;
Add-WindowsFeature RSAT-AD-PowerShell,RSAT-AD-AdminCenter
