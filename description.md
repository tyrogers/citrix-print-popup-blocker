# citrix-print-popup-blocker
Simple toolpack allowing quick system changes to reduce software friction while using the Citrix/HCHB desktop application. Blocks the incessant "Waiting for printer connection..." popups! :)

Basic flow:
graph TD
    Start([Launch Master_Toolbox.bat]) --> AdminCheck{Admin Rights?}
    AdminCheck -- No --> Error[Display Error & Exit]
    AdminCheck -- Yes --> Menu[Display Master Menu]

    Menu -- Choice 1 --> Popup[Popup_Blocker.ps1]
    Menu -- Choice 2 --> DLP[Print_DLP.ps1]
    Menu -- Choice 3 --> Both[Both Scripts]
    Menu -- Choice 4 --> RevDLP[Revert_Print_DLP.ps1]
    Menu -- Q --> Exit([Exit])

    subgraph "Popup Blocker Logic (Self-Healing)"
    Popup --> StopSpool[Stop Print Spooler]
    StopSpool --> Monitor[Monitor wfica32.exe Process]
    Monitor --> Closed{HCHB Closed or Key Pressed?}
    Closed -- Yes --> StartSpool[Start Print Spooler]
    StartSpool --> Menu
    end

    subgraph "DLP Protocol Logic"
    DLP --> CheckPDF{Print to PDF Enabled?}
    CheckPDF -- Yes --> DisablePDF[Disable Windows Feature]
    CheckPDF -- No --> Flush[Clear Spooler & Restart]
    DisablePDF --> Flush
    Flush --> Menu
    end

    subgraph "Reversion Logic"
    RevDLP --> CheckPDFRev{Print to PDF Disabled?}
    CheckPDFRev -- Yes --> EnablePDF[Enable Windows Feature]
    CheckPDFRev -- No --> Refresh[Refresh Spooler]
    EnablePDF --> Refresh
    Refresh --> Menu
    end
