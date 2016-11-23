function Get-LMxDashboard {
<#
.SYNOPSIS
    Retrieve dashboard list from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxDashboard -Session $session
    Return a list of all Dashboard objects in the connected portal.
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
 
        $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getDashboards"
        $Dashboards = ($r.Content|ConvertFrom-Json).data
    }

    process {
        $Dashboards
    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxDashboard @args
}
