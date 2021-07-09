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
        
        $ipaddress = Read-Host "What would you like to set the IP to?"
        Write-Host "Setting the IP Address to: " $ipaddress
        New-NetIPAddress -IPAddress $ipaddress
        Set-NetIPAddress -IPAddress $ipaddress
        Start-Sleep -Seconds 2.5

        $subnetmask = Read-Host "What would you like to set the Subnet mask to? Please submit the CIDR (/25, /32, etc.) with out the slash, aka '25'"
        Write-Host "Setting subnet mask to a /" $subnetmask
        Start-Sleep -Seconds 2.5
        Set-NetIPAddress -PrefixLength $subnetmask
        Start-Sleep -Seconds 2.5

        $gateway = Read-Host "What would you like to set the gateway to?"
        Write-Host "Setting Gateway to:" $gateway
        Start-Sleep -Seconds 2.5
        New-NetIPAddress -DefaultGateway $gateway
        Start-Sleep -Seconds 2.5

        $dnsserver = Read-Host "What would you like to set the DNS to?"
        Write-Host "Setting the DNS server to: " $dnsserver
        Start-Sleep -Seconds 2.5
        Set-DnsClientServerAddress -ServerAddresses $dnsserver
        Start-Sleep -Seconds 2.5

        #etcetc
        break;

  } elseif ($response -eq 'N' -or $response -eq 'n') {
      Write-Host "Moving on to the next adapter"
      
  }
  else{
      Write-Host "LEARN TO READ"
  }
}



Write-Host "Select from previous list the adapter you would like to configure:"


