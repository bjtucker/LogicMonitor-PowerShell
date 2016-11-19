function Get-LMxAlert {
<#
.SYNOPSIS
    Pull alert events from LogicMonitor connection
.DESCRIPTION
    Makes a connection to the specified LogicMonitor portal with given credential.
    Returns an object the active connection.
.PARAMETER Session
.EXAMPLE
    PS> Connect-LMxSession
    Start a LogicMonitor RPC API Session. Will prompt for portal name, username, and password
.EXAMPLE
    PS> $cred = Get-Credential
    PS> Connect-LMxSession -PortalName myportal -Credential $cred
    Starts a session to the portal myportal.logicmonitor.com. 
.EXAMPLE
    PS> Connect-LMxSession -PortalName myportal
    Starts a session to the portal myportal.logicmonitor.com. Will prompt for username and password
.OUTPUTS
    Returns a WebSession object connected to the specified LogicMonitor portal if successful
#>
    [CmdletBinding(PositionalBinding=$true)]
    [Alias()]
    [OutputType([String])]
    Param ([Parameter(Mandatory=$true,
                      Position=0,
                      ValueFromPipeline=$true,
                      ValueFromPipelineByPropertyName=$true,
                      ValueFromRemainingArguments=$false)]
            [ValidateNotNullOrEmpty()]
            [Alias("Portal")] 
            $PortalName,
 
            [Parameter(Mandatory=$True,Position=1)]
            [pscredential]
            $Credential

           )    

    $CupData = "c=$($Portalname)&u=$($Credential.UserName)&p=$($Credential.GetNetworkCredential().Password)"
    $BaseURI = 'https://' + $PortalName + '.logicmonitor.com/santaba/'
    $LoginURI = $BaseURI + 'rpc/signIn?' + $CupData

    $Session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    Invoke-WebRequest -UseBasicParsing -Uri $LoginURI -WebSession $session | Out-Null
    return @(Session=$Session; BaseURI=$BaseURI)
}




