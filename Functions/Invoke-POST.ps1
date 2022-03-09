function Invoke-POST {
    [CmdletBinding()]
    param (
        [String]$Uri,
        [PSCredential]$Credentials,
        [String]$Body
    )
    
    Begin {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function started"

        $base64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$($Credentials.UserName):$($Credentials.GetNetworkCredential().Password)"))
        $headers = @{ # default headers
            "Accept"         = "application/json"
            "Content-Type"   = "application/json"
            "Accept-Charset" = "utf-8"
            "Authorization"  = "Basic $($base64)"
        }

        $parameters = @{
            'Method'  = 'POST';
            'Headers' = $headers;
            'Uri'     =  $Uri}
            
        if ($Body -ne $null) {
            $parameters['Body'] = $Body
        }
    }

    Process {       
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Invoke-WebRequest with: $(([PSCustomObject]$parameters) | Out-String)"      

        Invoke-WebRequest @parameters
    }

    End {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}