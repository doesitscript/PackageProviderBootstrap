
import-module psdepend -Force
.\.build.ps1 -ResolveDependency
new-item $Target -itemType Directory
<#
psedit \Users\Administrator\AppData\Local\Temp\PSES-10656\RemoteFiles\1037641241\RT1-STR-SCH-01\
psedit \Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\Get-WebFile.ps1
psedit \Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\FileDownload.ps1
$InstallScope = 'Machine'
Import-$ResolveDependency
Install-PackageProviderAssembliesFromFile -ProviderName nuget -Scope $InstallScope

Install-PackageProviderAssembliesFromFile -ProviderName chocolatey -Scope $InstallScope
$cred = Get-Credential
if ( !(Compare-PackageProviderAssemblies -Scope $InstallScope -ProviderName Chocolatey) ) {
    'Present'
}
else {
    'Absent'
}
$username = "DoesItScript\Administrator"
$password = "Pass@w0rd1"
$secureStringPwd = $password | ConvertTo-SecureString -AsPlainText -Force 
$creds = New-Object System.Management.Automation.PSCredential -ArgumentList $username, $secureStringPwd
Enter-PSSession 192.168.50.97 -Credential $creds
cd .\PackageProviderBootstrap
psedit .\.build.ps1
if( (Test-Path $TargetParent) -and -not (Test-Path $Target) -and -not ($Target -Match '.+\\?' ))
[System.IO.Path]::GetExtension($pwd)
resolve-path (Join-Path $pwd $target)
test-path $path
Split-Path $DependencyFiles
$ThisDependencyFile
$Dependency
$Source = $Dependency.Source
$ThisDependency['DependencyFile']
$ThisDependency
$TheseDependencies
$Dependency
$webclient.DownloadFile($URL, $Path)
if (!$InstallScope) {$InstallScope = 'CurrentUser'}
Write-Verbose "Installing Chocolatey Provider"
Install-PackageProviderAssembliesFromFile -ProviderName Chocolatey -Scope $InstallScope

<#
DependencyFile  : C:\Users\Administrator\Documents\PackageProviderBootstrap\Dependencies.psd1
DependencyName  : Chocolatey
DependencyType  : Package
Name            :
Version         :
Parameters      : {}
Source          : NuGet
Target          : PackageProviderBootStrap\bin\Chocolatey\
AddToPath       : True
Tags            :
DependsOn       :
PreScripts      :
PostScripts     :
PSDependOptions : {AddToPath, Parameters, Target}
Raw             : {Target, Source, DependencyType}




VERBOSE: Searching for C:\Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\Package.ps1
VERBOSE: Searching for Package.ps1
VERBOSE: Get-Parameters for C:\Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\Package.ps1\Package.ps1
VERBOSE: Found parameters [Dependency ProviderName PSDependAction]
VERBOSE: Invoking 'C:\Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\Package.ps1' with parameters
Name                           Value
----                           -----
Dependency                     @{DependencyFile=C:\Users\Administrator\Documents\PackageProviderBootstrap\Dependencies.psd1; DependencyName=Chocolatey; Depen...
PSDependAction                 {Install}



VERBOSE: Repository details, Name = 'PSGallery', Location = 'https://www.powershellgallery.com/api/v2/'; IsTrusted = 'False'; IsRegistered = 'True'.
C:\Users\Administrator\Documents\WindowsPowerShell\Modules\PSDepend\0.1.56\PSDependScripts\Package.ps1 : PackageSource [NuGet] is not valid.  Valid sources:
PowerShellGet

\Users\Administrator\Documents\WindowsPowerShell\Modules\psdepend\0.1.56\PSDependScripts\Package.ps1

#>