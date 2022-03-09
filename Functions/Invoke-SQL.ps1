function Invoke-SQL {
    [CmdletBinding()]
    param (
        [String]$Query,
        [String]$Uri,
        [PSCredential]$Credentials,
        [String]$Format = "csv" #json|csv|raw values are allowed
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Uri = "$Uri/_opendistro/_sql?format=$Format"

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] $Uri"
        $Body = @{"query" = "$Query"} | ConvertTo-Json

    }

    Process {
       Invoke-POST -Uri $Uri -Credentials $Credentials -Body $Body    
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}