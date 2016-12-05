function Get-LMxEscalationChain {
<#
.SYNOPSIS
    Retrieve escalation chain list from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxEscalationChain -Session $session
    Return a list of all EscalationChain objects in the connected portal.
#>
    [CmdletBinding(PositionalBinding=$true)]
    [Alias()]
    [OutputType([String])]
    Param ([Parameter(ValueFromPipeline=$true,
                      ValueFromPipelineByPropertyName=$true,
                      ValueFromRemainingArguments=$true)]
            [ValidateNotNullOrEmpty()]
            [Alias("Session")]
            $LMSession = $global:LMSession
           )
    begin {
 
        $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getEscalationChains"
        $EscalationChains = ($r.Content|ConvertFrom-Json).data
    }

    process {
        $EscalationChains
    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxEscalationChain @args
}
