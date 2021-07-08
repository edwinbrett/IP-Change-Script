<#
This scripts purpose is to change IPs when configuring a VM for Private networking.
Under normal conditions, it should allow the selection of an Ethernet adapter, and change the IP and DNS for it

Made by Edwin Brett, Please reach out via https://Edwinbrett.com if you have any issues.
#>

Write-Host " IP Change Script
===================" -ForegroundColor Blue
Write-Host "Searching for Adapters..." -ForegroundColor Yellow

Get-NetAdapter | ForEach-Object ($_.Name){Get-NetIPConfiguration} 

$Adapters = (Get-NetAdapter).Name
foreach ($interface in $Adapters) {
  Write-Host "$interface found"
  $response = Read-Host "Is this the adpater you want to work with? : Y or N"
  if($response -eq 'Y' -or $response -eq 'y'){
        Write-Host "We will work on this adapter:" $interface
        #set ip 
        #set DNS
        #etcetc
        break;

  } elseif ($response -eq 'N' -or $response -eq 'n') {
      Write-Host "Moving on to the next adapter"
      
  }
  else{
      Write-Host "LEARN TO FUCKING READ"
  }
}



Write-Host "Select from previous list the adapter you would like to configure:"


