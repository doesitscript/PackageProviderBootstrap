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
        [System.String]
        $RunKey
    )

    
    #Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1

    $returnValue = @{
        Ensure = [System.String]$Ensure
        NuGetProvider =  get-PackageProvider | ? Name -eq 'NuGet'
    }

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

        [ValidateSet("CurrentUser","AllUsers")]
        [System.String]
        $Scope,

        [parameter(Mandatory = $true)]
        [System.String]
        $RunKey
    )

    Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1

    switch ($Ensure) {
        'Present' {
            Install-PackageProviderFromFile -ProviderName nuget -Scope $scope
        }

        'Absent' {
            
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

        [ValidateSet("CurrentUser","AllUsers")]
        [System.String]
        $Scope,

        [parameter(Mandatory = $true)]
        [System.String]
        $RunKey
    )

    Import-Module $PSScriptRoot\..\..\PackageProviderBootstrap.psd1
    #Write-Verbose "Use this cmdlet to deliver information about command processing."

    #Write-Debug "Use this cmdlet to write debug information while troubleshooting."


    <#
    $result = [System.Boolean]
    
    $result
    #>
}


Export-ModuleMember -Function *-TargetResource

