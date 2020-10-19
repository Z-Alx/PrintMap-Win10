Start-Transcript -Path C:\Tools\PrinterMap-Win10-v2.txt

$computerName = [Environment]::MachineName
$magNum = $computerName -replace @('(s)(\d{3})[wC](\d{3})','$2')
$csvpath = "\\fs" + $magNum + "\services_printer`$\printers.csv"
$ErrorActionPreference = 'stop'
try {

	Import-Csv -Delimiter '|' -Path $csvpath  | % -Begin {[HashTable]$HashTable = @{}} -Process {$HashTable[$_.User.Trim()] = $_.Printers -split ','}
}
catch{

	Write-Host "Can't access printers.csv file"
    $_.Exception
    exit
}

$ErrorActionPreference = 'Continue'
$i = 0
$ConnectedPrinters = @(Get-Printer -Full | ? shared -EQ $true)

"before connect"
$ConnectedPrinters

$ShopPrinters = @($HashTable[$ComputerName])
$ConnectedPrinters | ?{($_.Name -NotIn $ShopPrinters) -or ($_.PrinterStatus -NE 'Normal')} | select -ExpandProperty Name | %{
    
    Remove-Printer -Name $_
    Write-Host "$($_) removed"
}

"after remove"
Get-Printer -Full

$ShopPrinters | ?{$_ -notin $ConnectedPrinters.Name} | %{
    Add-Printer -ConnectionName $_.ToString()
    Write-Host "$($_) connected"
    sleep 1
}

"after connect"
Get-Printer -Full

sleep 1
(New-Object -ComObject WScript.Network).SetDefaultPrinter($ShopPrinters[0])
sleep 1

Stop-Transcript
exit
