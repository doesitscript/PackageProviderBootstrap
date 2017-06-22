function Test-ChocolateySource {
    [CmdletBinding()]
    Param(
        [Parameter(
            Mandatory
            ,ValueFromPipelineByPropertyName
        )]
        [String]
        $Name,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        $Source,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [switch]
        $Disabled,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [switch]
        $BypassProxy,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [switch]
        $SelfService,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [int]
        $Priority = 0,

        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [PSCredential]
        $Credential

    )

    Process {
        if (-not ($chocoCmd = Get-Command 'choco.exe' -CommandType Application -ErrorAction SilentlyContinue)) {
            Throw "Chocolatey Software not found"
        }

        if (-not ($Source = (Get-ChocolateySource -Name $Name)) ) {
            Write-Verbose "Chocolatey Source $Name cannot be found."
            Return $false
        }

        $ReferenceSource = [PSCustomObject]@{}
        foreach ( $Property in $PSBoundParameters.keys.where{
            $_ -notin ([System.Management.Automation.Cmdlet]::CommonParameters + [System.Management.Automation.Cmdlet]::OptionalCommonParameters)}
        )
        {
            if('Credential' -ne $Property) {
                $MemberParams = @{
                    MemberType = 'NoteProperty' 
                    Name = $Property 
                    Value = $PSboundParameters[$Property]
                }
                $ReferenceSource | Add-Member @MemberParams

                
            }
            else {
                $PasswordParam = @{
                    MemberType = 'NoteProperty' 
                    Name = 'password' 
                    Value = 'Reference Object Password'
                }
                $UserNameParam = @{
                    MemberType = 'NoteProperty' 
                    Name = 'username' 
                    Value = $Credential.UserName
                }
                $ReferenceSource | Add-Member @PasswordParam -passthru | Add-Member @UserNameParam

                $securePasswordStr = $Source.Password
                $SecureStr = [System.Convert]::FromBase64String($SecurePasswordStr)
                $salt = [System.Text.Encoding]::UTF8.GetBytes("Chocolatey")
                $PasswordBytes = [Security.Cryptography.ProtectedData]::Unprotect($SecureStr, $salt, [Security.Cryptography.DataProtectionScope]::LocalMachine)
                if([system.text.encoding]::UTF8.GetString($PasswordBytes) -eq $Credential.GetNetworkCredential().Password) {
                    Write-Verbose "The Password Match"
                    $Source.Password = 'Reference Object Password'
                }
                else {
                    Write-Verbose "The Password Do not Match"
                    $Source.Password = 'Source Object Password'
                }

            }
            
        }
        

        Compare-Object -ReferenceObject $ReferenceSource -DifferenceObject $Source -Property $ReferenceSource.PSObject.Properties.Name
        
        if($NewSource) {
            Unregister-ChocolateySource @NewSource
        }
    }
}