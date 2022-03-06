function Set-Credentials {    
    param (
        [uri]$OpenSearchUri,
        [PSCredential]$Credentials
    )

    Begin {

        function Add-DefaultParameter {
            param(
                [string]$Command,
                [string]$Parameter,
                $Value
            )

            Process {
                Write-Verbose "[$($MyInvocation.MyCommand.Name)] Setting [$command : $parameter] = $value"

                # http://stackoverflow.com/questions/30427110/set-psdefaultparametersvalues-for-use-within-module-scope
                $PSDefaultParameterValues["${command}:${parameter}"] = $Value
                $global:PSDefaultParameterValues["${command}:${parameter}"] = $Value
            }
        }

        $moduleCommands = Get-Command -Module OpenSearchPS
    }

    Process {
        foreach ($command in $moduleCommands) {

            $parameter = "OpenSearchUri"
            if ($OpenSearchUri -and ($command.Parameters.Keys -contains $parameter)) {
                Add-DefaultParameter -Command $command -Parameter $parameter -Value ($BaseURi.AbsoluteUri.TrimEnd('/'))
            }

            $parameter = "Credentials"
            if ($Credentials -and ($command.Parameters.Keys -contains $parameter)) {
                Add-DefaultParameter -Command $command -Parameter $parameter -Value $Credential
            }
        }
    }
}
