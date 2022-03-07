function Invoke-Method {
    [CmdletBinding()]
    param (
        [String]$Uri,
        [PSCredential]$Credentials,
        [String]$Body,
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method = "GET"
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($Credentials.UserName):$($Credentials.GetNetworkCredential().Password)"))
        $headers = @{ # default headers
            "Accept"         = "application/json"
            "Accept-Charset" = "utf-8"
            "Authorization"  = "Basic $($base64)"
            "Content-Type" = "application/json"
        }

        $parameters = @{}
    }

    Process {
        
        $parameters['Method'] = $Method
        $parameters['Headers'] = $headers
        $parameters['Uri'] = $Uri

        if ($Body -ne $null) {
            $parameters['Body'] = $Body
        }

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Invoke-WebRequest with: $(([PSCustomObject]$splatParameters) | Out-String)"
        
        Invoke-WebRequest @parameters    
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}