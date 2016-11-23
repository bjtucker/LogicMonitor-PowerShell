function Get-LMxAgent {
<#
.SYNOPSIS
    Retrieve collector list from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxAgent -Session $session
    Return a list of all Agent objects in the connected portal.
#>
    [CmdletBinding(PositionalBinding=$true)]
    [Alias()]
    [OutputType([String])]
    Param ([Parameter(Mandatory=$true,
                      Position=0,
                      ValueFromPipeline=$true,
                      ValueFromPipelineByPropertyName=$true,
                      ValueFromRemainingArguments=$true)]
            [ValidateNotNullOrEmpty()]
            [Alias("Session")]
            $LMSession
           )
    begin {
 
        $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getAgents"
        $Agents = ($r.Content|ConvertFrom-Json).data
    }

    process {
        $Agents
    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxAgent @args
}
