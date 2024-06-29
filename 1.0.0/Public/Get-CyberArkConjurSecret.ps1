<#
.Synopsis
    After Token is generated. Use the token to connect again and retrieve the secret.

.EXAMPLE 
    Get-CyberArkConjurSecret -ConjurCloudURL "XXXX.cyberark.cloud" -SecretID "data/vault/xxxxx/xxxxxx/password" -Token "Token"

.NOTES
    Modified by: Derek Hartman
    Date: 6/12/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-CyberArkConjurSecret {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Conjur Cloud URL.")]
        [string[]]$ConjurCloudURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Secret ID.")]
        [string[]]$SecretID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your API Key.")]
        [string[]]$Token
    )

    $Header = @{
        'Content-Type'     = 'application/json';
        'Authorization'  = "Token token=`"$($Token)`"";
    }
	
	$Uri = "https://$($ConjurCloudURL)/api/secrets/conjur/variable/$($SecretID)"

    $Response = Invoke-RestMethod -Uri $Uri -Method Get -Headers $Header
    Write-Output $Response
}