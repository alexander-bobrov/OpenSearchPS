$ModuleFunctions = @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )

# Dot source the functions
ForEach ($File in $ModuleFunctions) {
    Try {
        . $File.FullName
    }
    Catch {
        $errorItem = [System.Management.Automation.ErrorRecord]::new(
            ([System.ArgumentException]"Function not found"),
            'Load.Function',
            [System.Management.Automation.ErrorCategory]::ObjectNotFound,
            $File
        )
        $errorItem.ErrorDetails = "Failed to import function $($File.BaseName)"
        $PSCmdlet.ThrowTerminatingError($errorItem)
    }
}
