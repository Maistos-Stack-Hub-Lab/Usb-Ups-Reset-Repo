# CyberPower UPS Soft Reset Script (Windows)
# Version: v1.4.0-dev

$vendorId = "0764"  # CyberPower Vendor ID
$logFile = "$env:TEMP\ups_reset_soft.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Path $logFile -Value "[$date] Starting UPS Soft Reset"

# Detect UPS devices via PNPUTIL (optional, or use external tool)
$devices = Get-PnpDevice -PresentOnly | Where-Object { $_.InstanceId -match "USB" -and $_.FriendlyName -match "CyberPower" }

if ($devices) {
    foreach ($device in $devices) {
        $id = $device.InstanceId
        $log = "[$date] Found UPS: $id"
        Write-Output $log
        Add-Content -Path $logFile -Value $log

        # Attempt disable/enable cycle
        Disable-PnpDevice -InstanceId $id -Confirm:$false
        Start-Sleep -Seconds 3
        Enable-PnpDevice -InstanceId $id -Confirm:$false

        Add-Content -Path $logFile -Value "[$date] Soft reset completed for $id"
    }
} else {
    Add-Content -Path $logFile -Value "[$date] No CyberPower UPS detected"
}
