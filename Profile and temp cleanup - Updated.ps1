#Task scheduler task setup: https://social.technet.microsoft.com/wiki/contents/articles/38580.windows-task-scheduler-configure-to-run-a-powershell-script.aspx

#powershell cleanup temp profile data: https://devblogs.microsoft.com/scripting/weekend-scripter-use-powershell-to-clean-out-temp-folders/

#Background story, I LIKE to see space on the drive, BEFORE being cleaned, and after to compare space cleaned.


Start-transcript -path c:\temp\CleanupLogs\$(get-date -Format yyyyddmm_hhmmtt).txt

$ErrorActionPreference = 'SilentlyContinue'

$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace

"Disk Size" 
$disk.Size / 1GB

 "Disk Free Space Pre Cleanup" 
 $disk.FreeSpace / 1GB

$tempfolders = @("C:\Windows\Temp\*","C:\Users\*\AppData\Roaming\Local\Microsoft\Windows\InetCache\Content.IE5","C:\Users\*\AppData\Local\Google\Chrome\User Data\*\Cache","C:\Users\*\AppData\Local\Temp")
Remove-Item $tempfolders -force -recurse -verbose

$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace

"Disk Size" 
$disk.Size / 1GB

 "Disk Free Space Post Cleanup" 
 $disk.FreeSpace / 1GB

 stop-transcript