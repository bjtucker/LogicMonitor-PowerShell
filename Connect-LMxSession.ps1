function Connect-LMxSession.ps1 {
<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER PortalName
.EXAMPLE
Connect-LMxSession -PortalName myportal
Starts a session to the portal myportal.logicmonitor.com. Will prompt for password
#>
    [CmdletBinding(SupportsShouldProcess=$true,
                   PositionalBinding=$false)]
    [Alias()]
    [OutputType([String])]
    Param ([Parameter(Mandatory=$true,
                      Position=0,
                      ValueFromPipeline=$true,
                      ValueFromPipelineByPropertyName=$true,
                      ValueFromRemainingArguments=$false, 
                      ParameterSetName='Parameter Set 1')]
            [ValidateNotNullOrEmpty()]
            [Alias("Portal")] 
            $PortalName)

        begin {
        }
        
        process {
            
        }
        
        end {
        }
    }
}
