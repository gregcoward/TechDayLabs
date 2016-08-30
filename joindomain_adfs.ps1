### Parameters ###
param($dom)
$domain = $dom + ".f5demo.net"
$password = "F5testnet" | ConvertTo-SecureString -asPlainText -Force
$username = $dom + "\xuser" 
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
$Domaininfo=Get-ADDomain

########## Join webserver to domain ########
Add-Computer -DomainName $domain -Credential $credential;
invoke-command –computername MyServer –scriptblock {(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(1)};
import-module ServerManager
Install-windowsfeature -name AD-Domain-Services –IncludeManagementTools


########## Install and Configure ADFS ########
$ADFSdisplayName = $Dom + ' Fed Service Name'
$CertificateADFSsubject="fs.lab.f5demo.net"
$CAsubject="f5demo-DC-CA"
$ADFSpswd = "F5testnet"
$CertificateLocalPath = "C:\files\"
$CertificateADFS = "$CertificateADFSsubject.pfx"
$CA = "$CAsubject.cer"
 
### Preparation
$CertificateADFSLocalPath = $CertificateLocalPath + $CertificateADFS
$CertificateADFSsubjectCN = "CN=" + $CertificateADFSsubject
$CALocalPath = $CertificateLocalPath + $CA
$CAsubjectCN = "CN=" + $CAsubject

cd $CertificateLocalPath


### Install Certifiates
Import-Certificate –FilePath $CALocalPath -CertStoreLocation cert:\localMachine\root
Import-PfxCertificate –FilePath $CertificateADFSLocalPath -CertStoreLocation cert:\localMachine\my -Password $password


## Configure ADFS
Add-WindowsFeature NET-Framework-Core, ADFS-Federation -IncludeManagementTools
Import-Module ADFS
$CertificateThumbprint = (dir Cert:\LocalMachine\My | where {$_.subject -match $CertificateADFSsubjectCN}).thumbprint
Install-AdfsFarm -CertificateThumbprint $CertificateThumbprint  -FederationServiceDisplayName $ADFSdisplayName -FederationServiceName $CertificateADFSsubject -ServiceAccountCredential $Credential -OverwriteConfiguration 

######## Disable the Windows Firewall ########
netsh advfirewall set allprofiles state off;


