$computerName = [Environment]::MachineName
$magNum = $computerName -replace @('(s)(\d{3})[wC](\d{3})','$2')
$csvpath = "\\fs" + $magNum + "\services_printer`$\printers.csv"
try {

	Import-Csv -Delimiter '|' -Path $csvpath  | % -Begin {[HashTable]$HashTable = @{}} -Process {$HashTable[$_.User.Trim()] = $_.Printers -split ','}
}
catch{

	exit
}
$i = 0
$ConnectedPrinters = @(Get-Printer -Full | ? shared -EQ $true)
$ShopPrinters = @($HashTable[$ComputerName])
$ConnectedPrinters.Name | %{ Remove-Printer -Name $_}
do{
$i++
$ShopPrinters | %{ 
Add-Printer -ConnectionName $_ 
sleep 1
}
$checkPrinters = @(Get-Printer -Full | ? shared -EQ $true)

}while(($i -lt 2) -and !($checkPrinters))
sleep 1
(New-Object -ComObject WScript.Network).SetDefaultPrinter($ShopPrinters[0])
sleep 1
exit
