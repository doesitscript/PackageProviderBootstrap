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
    
    if( !(Compare-PackageProviderAssemblies -Scope $InstallScope -ProviderName nuget) ) {
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
            Write-Verbose "Installing Nuget Provider"
            Install-PackageProviderAssembliesFromFile -ProviderName nuget -Scope $InstallScope
        }

        'Absent' {
            Write-Verbose "Uninstalling Nuget Provider"
            Uninstall-PackageProviderAssemblies -ProviderName nuget -Scope $InstallScope
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


Export-ModuleMember -Function *-TargetResource

