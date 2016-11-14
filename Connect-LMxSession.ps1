function Connect-LMxSession {
<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER PortalName
.PARAMETER Credential
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
            $PortalName,

            [Parameter(Mandatory=$True,Position=1)]
            [pscredential]
            $Credential


           )    

    begin {
    }
        
    process {
            
    }
        
    end {
    }
}