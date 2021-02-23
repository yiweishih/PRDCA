$source = "https://github.com/angryziber/ipscan/releases/download/3.5.1/ipscan-3.5.1-setup.exe";
$destination = "C:\PRDCA_IT\IpScanner.exe"

if ((Test-Path "C:\Program Files\Angry IP Scanner") -Or (Test-Path "C:\Program Files (x86)\Angry IP Scanner")){
write-host "Software already installed" 
Exit
}

Invoke-WebRequest $source -OutFile $destination

Start-Process -FilePath "C:\PRDCA_IT\IpScanner.exe" -ArgumentList "/S","/v","/qn" -Wait runas

#$pathvargs = {C:\PRDCA_IT\IpScanner.exe /S /v/qn }

#Invoke-Command -ScriptBlock $pathvargs 

#Delete installer

Remove-Item -recurse "C:\PRDCA_IT\IpScanner.exe"
