if ((Get-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features").State -eq "Enabled") {
    Disable-WindowsOptionalFeature -Online -FeatureName "Printing-PrintToPDFServices-Features" -NoRestart
}
Stop-Service "Spooler" -Force
Get-ChildItem "C:\Windows\System32\spool\PRINTERS\*" | Remove-Item -Force
Start-Service "Spooler"

Write-Host "Print to PDF disabled. DLP protocol active."