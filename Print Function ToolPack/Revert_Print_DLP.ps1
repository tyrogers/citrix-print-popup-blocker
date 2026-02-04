#Revert changes from Print_DLP.ps1
if ((Get-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features").State -ne "Enabled") {
    Write-Host "Enabling Microsoft Print to PDF..." -ForegroundColor Yellow
    Enable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart
} else {
    Write-Host "Print to PDF is already enabled." -ForegroundColor Cyan
}

#Refresh spooler for immediate access
Stop-Service "Spooler" -Force
Start-Service "Spooler"

Write-Host "Reversion complete. Print to PDF is now available." -ForegroundColor Green