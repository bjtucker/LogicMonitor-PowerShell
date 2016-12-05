function Get-LMxHostGroup {
<#
.SYNOPSIS
    Retrieve host groups from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxHostGroup -Session $session
    Return a list of all hostGroup objects in the connected portal.   
.EXAMPLE
    PS> Get-LMxHostGroup -hostGroupId HOSTGROUPID -Session $session
    Return the hostGroup object specified by HOSTID.   
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

            [Parameter(Position=1)]
            [Alias("groupId")]
            $hostGroupId
           )
    begin {
        $RPCParameters = @{}
 
        # if hostGroupId specified, use getHostGroup to retrieve single entity. 
        if ($hostGroupId) {
            $RPCParameters['hostGroupId']=$hostGroupId
             $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getHostGroup" -Body $RPCParameters
             $hostGroups = ($r.Content|ConvertFrom-Json).data

        } else {
             $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getHostGroups" -Body $RPCParameters
             $hostGroups = ($r.Content|ConvertFrom-Json).data
        }
    }

    process {
        $hostGroups

    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxHostGroup @args
}
