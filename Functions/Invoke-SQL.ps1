function Invoke-SQL {
    [CmdletBinding()]
    param (
        [String]$Query,
        [String]$Uri,
        [PSCredential]$Credentials
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Uri = "$Uri/_opendistro/_sql"

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