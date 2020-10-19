Start-Transcript -Path C:\Tools\RemovePrintersRegistry.txt

# delete printers
Get-Printer -Full | ? Shared -EQ $true | Remove-Printer -Confirm:$false
Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Providers\Client Side Rendering Print Provider" -Recurse
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceClasses\{0ecef634-6ef0-472a-8085-5ad023ecbccd}" -Recurse
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Enum\SWD\PRINTENUM" -Recurse

Stop-Transcript
