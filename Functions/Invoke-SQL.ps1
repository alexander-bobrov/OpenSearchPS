function Invoke-SQL {
    param (
        [string]$Query,
        [uri]$OpenSearchUri,
        [PSCredential]$Credentials
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $Uri = "$OpenSearchUri/_plugins/_sql?sql=$Query"
    }

    Process {
       Invoke-Method -Uri $Uri -Credentials $Credentials
        
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}