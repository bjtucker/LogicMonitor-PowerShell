function Get-LMxHost {
<#
.SYNOPSIS
    Retrieve hosts from LogicMonitor portal. 
.EXAMPLE
    PS> Get-LMxHost -Session $session
    Return a list of all host objects in the connected portal.   
.EXAMPLE
    PS> Get-LMxHost -hostGroupId HOSTGROUPID -Session $session
    Return a list of all host objects in the specified host group.   
.EXAMPLE
    PS> Get-LMxHost -hostId HOSTID -Session $session
    Return the host object specified by HOSTID.   
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
            $LMSession,

            [Parameter()]
            [Alias("name")] 
            $displayName,

            [Parameter()]
            [Alias("groupId")] 
            $hostGroupId=1
           )
    begin {
        $RPCParameters = @{}
 
        # if displayName specified, use getHost to retrieve single entity. 
        if ($displayName) {
            $RPCParameters['displayName']=$displayName
             $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getHost" -Body $RPCParameters
             $hosts = ($r.Content|ConvertFrom-Json).data

        } else {
             $RPCParameters['hostGroupId']=$hostGroupId
             $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getHosts" -Body $RPCParameters
             $hosts = ($r.Content|ConvertFrom-Json).data.hosts
        }
    }

    process {
        $hosts

    }
    
}

if ($MyInvocation.CommandOrigin -eq "Runspace") {
    Get-LMxHost @args
}

