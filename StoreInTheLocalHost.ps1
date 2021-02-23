$test_url = "github.com"
$maxRetries = 5; $retryCount = 0; $keepgoing = $false

while (-not $keepgoing) {
    if ((Test-Connection -computername $test_url -Quiet) -eq $true) {
        Write-Verbose "We can reach out GitHub!!"
        $keepgoing = $true
    }
    else {
        if ($retryCount -ge $maxRetries) {
            throw "Failed connecting the GitHub within '$maxRetries' retries" # Terminating errors
        } else {
            Write-Verbose "GitHub not connect, retrying in 5 seconds."
            Start-Sleep '30'
            $retryCount++
        }
    }
}

if (-not (Test-Path C:\PRDCA_IT)) {
  Write-Verbose -Message "Creating the Folder for the Git Project " -Verbose
  New-Item -ItemType "directory" -Path "C:\PRDCA_IT"
  $f = get-item "C:\PRDCA_IT" -Force
  $f.attributes="Hidden"
}


if (Test-Path C:\PRDCA_IT\WindowsTest) {
  Write-Verbose -Message "Deleting the old git repo" -Verbose
  Set-Location C:\PRDCA_IT\WindowsTest
  git remote rm origin
  Set-Location C:\PRDCA_IT
  Remove-Item C:\PRDCA_IT\WindowsTest -Recurse -Force
}

if (Test-Path C:\PRDCA_IT\PRDCA_IT) {
  Write-Verbose -Message "Deleting the old git repo" -Verbose
  Set-Location C:\PRDCA_IT\PRDCA_IT
  git remote rm origin
  Set-Location C:\PRDCA_IT
  Remove-Item C:\PRDCA_IT\PRDCA_IT -Recurse -Force
}

Set-Location C:\PRDCA_IT

git clone https://github.com/yiweishih/PRDCA_IT.git
git clone https://github.com/yiweishih/WindowsTest.git

Get-ChildItem 'C:\PRDCA_IT\PRDCA_IT' | ForEach-Object {
  & $_.FullName
}

Set-Location C:\PRDCA_IT\WindowsTest
git remote rm origin
Set-Location C:\PRDCA_IT
Remove-Item C:\PRDCA_IT\WindowsTest -Recurse -Force

Set-Location C:\PRDCA_IT\PRDCA_IT
git remote rm origin
Set-Location C:\PRDCA_IT
Remove-Item C:\PRDCA_IT\PRDCA_IT -Recurse -Force
