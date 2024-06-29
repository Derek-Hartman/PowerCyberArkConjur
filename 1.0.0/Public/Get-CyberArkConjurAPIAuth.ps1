<#
.Synopsis
    Uses API token to Auth to CyberArk Conjur Cloud

.EXAMPLE 
    Get-CyberArkConjurAPIAuth -ConjurCloudURL "XXXX.cyberark.cloud" -WorkflowID "data/XXXXX" -APIKey "APIKey"

.NOTES
    Modified by: Derek Hartman
    Date: 6/12/2024

#>
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Function Get-CyberArkConjurAPIAuth {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Conjur Cloud URL.")]
        [string[]]$ConjurCloudURL,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your Workflow ID.")]
        [string[]]$WorkflowID,

        [Parameter(Mandatory = $True,
            ValueFromPipeline = $True,
            HelpMessage = "Enter your API Key.")]
        [string[]]$APIKey
    )

    $Header = @{
        'Content-Type'     = 'application/json';
        'Accept-Encoding'  = 'base64';
    }

    $Body = "$APIKey"
	
	$Uri = "https://$($ConjurCloudURL)/api/authn/conjur/host/$($WorkflowID)/authenticate"

    $Response = Invoke-RestMethod -Uri $Uri -Method Post -Headers $Header -Body $Body
    Write-Output $Response
}