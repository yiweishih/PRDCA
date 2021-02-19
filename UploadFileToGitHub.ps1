Set-Location D:\github\WindowsTest

$hostname = hostname

$date = (Get-Date).AddDays(-1).ToString('MM-dd-yyyy')

$filename_AppList = $hostname+"_"+$date+"_AppList"
$filename_UpdateList = $hostname+"_"+$date+"_UpdateList"

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Export-Csv -Path D:\github\WindowsTest\AppList.csv -NoTypeInformation

if (Test-Path D:\github\WindowsTest\$filename_AppList.csv) {
  Write-Verbose -Message "Deleting the duplicate file ($filename_AppList.csv)" -Verbose
  git rm D:\github\WindowsTest\$filename_AppList.csv
  git commit -m "Remove the duplicate file ($filename_AppList.csv)"
  git push
  #Remove-Item D:\github\WindowsTest\$filename_AppList.csv
}

Import-Csv -Path "D:\github\WindowsTest\AppList.csv" | Where-Object { $_.PSObject.Properties.Value -ne '' } | Export-Csv -Path D:\github\WindowsTest\$filename_AppList.csv -NoTypeInformation
Remove-Item "D:\github\WindowsTest\AppList.csv"


Get-Hotfix | Export-Csv -Path D:\github\WindowsTest\UpdateList.csv -NoTypeInformation

if (Test-Path D:\github\WindowsTest\D:\github\WindowsTest\$filename_UpdateList.csv) {
  Write-Verbose -Message "Deleting the duplicate file ($filename_UpdateList.csv)" -Verbose
  git rm D:\github\WindowsTest\D:\github\WindowsTest\$filename_UpdateList.csv
  git commit -m "Remove the duplicate file ($filename_UpdateList.csv)"
  git push
  #Remove-Item D:\github\WindowsTest\D:\github\WindowsTest\$filename_UpdateList.csv
}

Import-Csv -Path "D:\github\WindowsTest\UpdateList.csv" | Where-Object { $_.PSObject.Properties.Value -ne '' } | Export-Csv -Path D:\github\WindowsTest\$filename_UpdateList.csv -NoTypeInformation
Remove-Item "D:\github\WindowsTest\UpdateList.csv"



git add .\$filename_AppList.csv
git add .\$filename_UpdateList.csv
git commit -m "Yiwei added $filename_AppList & $filename_UpdateList"
git push

