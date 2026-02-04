############### Master Batch Script

Master_Toolbox.bat
Function: Allows execution of any implementation or reversion script below. Provides a basic user interface which simplifies the process of using the tools.


############### Implementation Scripts

Popup_Blocker.ps1 Function: Temporarily disables the local print spooler to resolve HDX Engine UI hangs ("Waiting for printer connection..." popups) specifically while HCHB/Citrix is active. 
Mechanism: Forces the "Spooler" service to Stop, monitors the wfica32.exe process, and automatically restarts the service once the process terminates. 
Notes: A self-healing script that eliminates the need for manual reversion; ensures the local spooler is only disabled during the active session.

Print_DLP.ps1
Function: Disables Microsoft Print to PDF on a system level, implements a soft DLP (Data Loss Prevention) protocol by removing the Microsoft Print to PDF feature.
Mechanism: Disables the Windows Optional Feature "Printing-PrintToPDFServices-Features".
Notes: Prevents users from generating portable, unencrypted ePHI files via virtual printing. This is a system-wide change.

############### Reversion Scripts

Revert_Print_DLP.ps1
Function: Re-enables the Microsoft Print to PDF system feature.
Mechanism: Sets "Printing-PrintToPDFServices-Features" to "Enabled".
Notes: Reverting this script removes the block on unencrypted PDF generation; system security posture for ePHI is lowered.