function Get-LMxAlert {
<#
.SYNOPSIS
    Retrieve alert events from LogicMonitor portal.
.DESCRIPTION
    Gets alert events from the specified LogicMonitor session.    
.EXAMPLE
    PS> Get-LMxAlert -Session $session
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
            [Alias("Session")]
            $LMSession,

            [Parameter()]
            [Alias("alertId")] 
            $id,

            [Parameter()]
            [Alias("alertType")] 
            $type,

            [Parameter()]
            [Alias("hostgroupName")] 
            $group,

            [Parameter()]
            [Alias("host")] 
            $hostName,

            [Parameter()]
            $hostId,

            [Parameter()]
            [Alias("dataSourceName")] 
            $dataSource,

            [Parameter()]
            [Alias("dataPointName")] 
            $dataPoint,

            [Parameter()]
            [Alias("startTime")] 
            $startEpoch,

            [Parameter()]
            [Alias("endTime")] 
            $endEpoch,

            [Parameter()]
            $ackFilter,

            [Parameter()]
            $filterSDT,

            [Parameter()]
            [Alias("alertLevel")] 
            $level,

            [Parameter()]
            $orderBy,

            [Parameter()]
            $orderDirection,

            [Parameter()]
            $includeInactive,

            [Parameter()]
            $needTotal,

            [Parameter()]
            [Alias("numberOfResults")] 
            $results,

            [Parameter()]
            [Alias("startResult")] 
            $start,

            [Parameter()]
            $needMessage
           )    

    begin {
        $RPCParameters = $PSBoundParameters
        $RPCParameters.Remove('LMSession') | Out-Null

        # 'host' gets special treatment. it's a reserved name, so can't be specified in Parameters 
        if ($RPCParameters['hostName']) {
            $RPCParameters['host'] = $RPCParameters['hostName']
            $RPCParameters.Remove('hostName') | Out-Null
        }

         $r = invoke-webrequest -UseBasicParsing -WebSession $LMSession.WebSession -Method Get -Uri "$($LMsession.BaseURI)rpc/getAlerts" -Body $RPCParameters
    }

    process {
        ($r.Content|ConvertFrom-Json).data.alerts
    }

    
}

Get-LMxAlert @args


