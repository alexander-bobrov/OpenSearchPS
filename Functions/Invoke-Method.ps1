function Invoke-Method {
    param (
        [uri]$Uri,
        [PSCredential]$Credentials,
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = "GET"
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($Credential.UserName):$($Credential.GetNetworkCredential().Password)"))
        $headers = @{ # default headers
            "Accept"         = "application/json"
            "Accept-Charset" = "utf-8"
            "Authorization"  = "Basic $($base64)"
        }
    }

    Process {
        
        Invoke-WebRequest -Method $Method -Uri $Uri -Headers $headers     
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}