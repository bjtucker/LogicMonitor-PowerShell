function Get-LMxAccount {
<#
.SYNOPSIS
    Retrieve account list from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxAccount -Session $session
    Return a list of all Account objects in the connected portal.
#>
    [CmdletBinding(PositionalBinding=$true)]
    [Alias()]
    [OutputType([String])]
    Param (
            # An active LogicMonitor Session.
            [Parameter(Position=0,
                      ValueFromPipeline=$true,
                      ValueFromPipelineByPropertyName=$true,
                      ValueFromRemainingArguments=$true)]
            [ValidateNotNullOrEmpty()]
            [Alias("Session")]
            $LMSession = $global:LMSession
           )
    begin {
 
        # if AccountId specified, use getAccount to retrieve single entity. 
        $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getAccounts"
        $Accounts = ($r.Content|ConvertFrom-Json).data
    }

    process {
        $Accounts
    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxAccount @args
}
