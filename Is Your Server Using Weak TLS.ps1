$protocols = @('TLS 1.0', 'TLS 1.1', 'TLS 1.2', 'TLS 1.3')
$roles     = @('Client', 'Server')
$basePath  = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols"

$results = foreach ($protocol in $protocols) {
    foreach ($role in $roles) {
        $regPath = "$basePath\$protocol\$role"

        if (Test-Path $regPath) {
            $item = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
            $enabledVal = $item.Enabled
            $disabledByDefaultVal = $item.DisabledByDefault

            if ($enabledVal -eq 0 -or $disabledByDefaultVal -eq 1) {
                $status = "Explicitly Disabled"
            } elseif ($enabledVal -eq 1) {
                $status = "Explicitly Enabled"
            } else {
                $status = "Configured (Partial Key)"
            }
        } else {
            $enabledVal = "N/A"
            $disabledByDefaultVal = "N/A"
            $status = "Not Configured (OS Default)"
        }

        [PSCustomObject]@{
            Protocol          = $protocol
            Role              = $role
            Status            = $status
            Enabled           = $enabledVal
            DisabledByDefault = $disabledByDefaultVal
        }
    }
}

$results | Format-Table -AutoSize