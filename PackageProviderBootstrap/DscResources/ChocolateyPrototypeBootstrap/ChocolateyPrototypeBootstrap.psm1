function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,

        [parameter(Mandatory = $true)]
        [ValidateSet("CurrentUser","AllUsers")]
        [System.String]
        $InstallScope,

        [parameter(Mandatory = $true)]
        [System.String]
        $RunKey
    )

    Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1

    if(!$InstallScope) {$InstallScope = 'CurrentUser'}
    
    if( !(Compare-PackageProviderAssemblies -Scope $InstallScope -ProviderName Chocolatey) ) {
       $ActualEnsure = 'Present'
    }
    else {
        $ActualEnsure = 'Absent'
    }

    Write-output -inputObject (@{
        Ensure = $ActualEnsure
        RunKey = $runKey
    })
}


function Set-TargetResource
{
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,

        [parameter(Mandatory = $true)]
        [ValidateSet("CurrentUser","AllUsers")]
        [System.String]
        $InstallScope,

        [parameter(Mandatory = $true)]
        [System.String]
        $RunKey
    )

    Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1

    if(!$InstallScope) {$InstallScope = 'CurrentUser'}

    switch ($Ensure) {
        'Present' {
            Write-Verbose "Installing Chocolatey Provider"
            Install-PackageProviderAssembliesFromFile -ProviderName Chocolatey -Scope $InstallScope
        }

        'Absent' {
            Write-Verbose "Uninstalling Chocolatey Provider"
            Uninstall-PackageProviderAssemblies -ProviderName Chocolatey -Scope $InstallScope
        }
    }

}


function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Present","Absent")]
        [System.String]
        $Ensure,

        [parameter(Mandatory = $true)]
        [ValidateSet("CurrentUser","AllUsers")]
        [System.String]
        $InstallScope,

        [parameter(Mandatory = $true)]
        [System.String]
        $RunKey
    )

    Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1
    if(!$InstallScope) {$InstallScope = 'CurrentUser'}

    $CurrentState = Get-TargetResource -Ensure $Ensure -InstallScope $InstallScope -RunKey $Runkey
    Write-Output -InputObject ($CurrentState.Ensure -eq $Ensure)
}



