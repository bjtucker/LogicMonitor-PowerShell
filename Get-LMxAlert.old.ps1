<#
.SYNOPSIS
    Get LogicMonitor alerts
.DESCRIPTION
    Get LogicMonitor alerts from an established RPC API session.
.PARAMETER Session
    The LogicMonitor RPC API session to use
.EXAMPLE
    PS> Get-LMxAlert -Session $session
.EXAMPLE
    PS> Connect-LMxSession | Get-LMxAlert
.OUTPUTS
    Returns zero or more Alert objects
#>
function Get-LMxAlert-Noun {
    [CmdletBinding()]
    [Alias()]
    [OutputType([String])]
    Param (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   Position=0,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ValueFromRemainingArguments=$false, 
                   ParameterSetName='Parameter Set 1')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,5)]
        [ValidateSet("sun", "moon", "earth")]
        [Alias("p1")] 
        $Param1,
        
        # Param2 help description
        [Parameter(ParameterSetName='Parameter Set 1')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [ValidateScript({$true})]
        [ValidateRange(0,5)]
        [int]
        $Param2,
        
        # Param3 help description
        [Parameter(ParameterSetName='Another Parameter Set')]
        [ValidatePattern("[a-z]*")]
        [ValidateLength(0,15)]
        [String]
        $Param3
    )
    
    begin {
    }
    
    process {
        ($r.Content|ConvertFrom-Json).data.alerts
    }
    
    end {
    }
}