if (Test-Path D:\github\WindowsTest) {
  Write-Verbose -Message "Deleting the old git repo" -Verbose
  Set-Location D:\github\WindowsTest
  git remote rm origin
  Set-Location D:\github
  Remove-Item D:\github\WindowsTest -Recurse -Force
}

if (Test-Path D:\github\PRDCA) {
  Write-Verbose -Message "Deleting the old git repo" -Verbose
  Set-Location D:\github\PRDCA
  git remote rm origin
  Set-Location D:\github
  Remove-Item D:\github\PRDCA -Recurse -Force
}

Set-Location D:\github

git clone https://github.com/yiweishih/PRDCA.git
git clone https://github.com/yiweishih/WindowsTest.git

Set-Location D:\github\WindowsTest

$hostname = hostname

$date = get-date -Format "MM-dd-yyyy"

$filename_AppList = $hostname+"_"+$date+"_AppList"+".csv"
$filename_UpdateList = $hostname+"_"+$date+"_UpdateList"+".csv"

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion | Export-Csv -Path D:\github\WindowsTest\AppList.csv -NoTypeInformation


if (Test-Path D:\github\WindowsTest\$filename_AppList) {
  Write-Verbose -Message "Deleting the duplicate file ($filename_AppList)" -Verbose
  Set-Location D:\github\WindowsTest
  git rm "$filename_AppList"
  git commit -m "Remove the duplicate file ($filename_AppList)"
  git push
}


Import-Csv -Path "D:\github\WindowsTest\AppList.csv" | Where-Object { $_.PSObject.Properties.Value -ne '' } | Export-Csv -Path D:\github\WindowsTest\$filename_AppList -NoTypeInformation
Remove-Item "D:\github\WindowsTest\AppList.csv"


Get-Hotfix | Export-Csv -Path D:\github\WindowsTest\UpdateList.csv -NoTypeInformation


if (Test-Path D:\github\WindowsTest\$filename_UpdateList) {
  Write-Verbose -Message "Deleting the duplicate file ($filename_UpdateList)" -Verbose
  Set-Location D:\github\WindowsTest
  git rm "$filename_UpdateList"
  git commit -m "Remove the duplicate file ($filename_UpdateList)"
  git push
}


Import-Csv -Path "D:\github\WindowsTest\UpdateList.csv" | Where-Object { $_.PSObject.Properties.Value -ne '' } | Export-Csv -Path D:\github\WindowsTest\$filename_UpdateList -NoTypeInformation
Remove-Item "D:\github\WindowsTest\UpdateList.csv"

git add $filename_AppList
git add $filename_UpdateList
git commit -m "Yiwei added $filename_AppList & $filename_UpdateList"
git push


git remote rm origin
Set-Location D:\github
Remove-Item D:\github\WindowsTest -Recurse -Force

Set-Location D:\github\PRDCA
git remote rm origin
Set-Location D:\github
Remove-Item D:\github\PRDCA -Recurse -Force





