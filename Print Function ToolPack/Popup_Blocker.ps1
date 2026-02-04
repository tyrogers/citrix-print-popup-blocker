#Disable printing spooler
Stop-Service Spooler -Force
Write-Host "HCHB Popup Fix Active. Printing is Disabled." -ForegroundColor Yellow

# 2. Monitor wfica32.exe with manual killswitch
Write-Host "Monitoring HCHB (wfica32.exe)..."
Write-Host "The Spooler will restart automatically when HCHB closes." -ForegroundColor Cyan
Write-Host "OR: Press any key to restore the Spooler manually and exit." -ForegroundColor Gray

# Create a background task to wait for the process
$job = Start-Job -ScriptBlock {
    $process = Get-Process wfica32 -ErrorAction SilentlyContinue
    if ($process) {
        $process | Wait-Process
    }
}

# Wait for either the process to end OR a key press
while ($job.State -eq "Running") {
    if ([System.Console]::KeyAvailable) {
        $null = [System.Console]::ReadKey($true)
        Stop-Job $job
        break
    }
    Start-Sleep -Milliseconds 500
}

# 3. Auto-Undo
Remove-Job $job -Force
Start-Service Spooler
Write-Host "Spooler is back ON." -ForegroundColor Green