 <#
This scripts purpose is to change IPs when configuring a VM for Private networking.
Under normal conditions, it should allow the selection of an Ethernet adapter, and change the IP and DNS for it

Made by Edwin Brett, Please reach out via https://Edwinbrett.com if you have any issues.
#>

Write-Host " IP Change Script
===================" -ForegroundColor Blue
Write-Host "Searching for Adapters..." -ForegroundColor Yellow

try{
$pattern = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$'
$subnetPattern = '\b([0-9]|[1-2][0-9]|3[0-2])\b'
$Adapters = Get-NetAdapter
if($null -ne $interface){
    foreach ($interface in $Adapters) {
        Write-Host "$($interface.Name) found"
        $response = Read-Host "Is this the adpater you want to work with? : Y or N"
        if($response -eq 'Y' -or $response -eq 'y'){
                Write-Host "We will work on this adapter:" $interface.Name
    
                do {
                    $ipaddress =  Read-Host "What would you like to set the IP to?"
                    $gateway = Read-Host "What would you like to set the gateway to?"
                    $dnsserver = Read-Host "What would you like to set the DNS to?"
                    $subnetmask = Read-Host "What would you like to set the Subnet mask to? Please submit the CIDR (/25, /32, etc.) with out the slash, aka '25'"

                    $ipCheck = $ipaddress -match $pattern
                    if ($ipCheck -eq $false) {
                      Write-Warning ("'{0}' is not a valid IP Address." -f $ipaddress)
                      
                    }

                    $gatewayCheck = $gateway -match $pattern
                    if ($gatewayCheck -eq $false) {
                      Write-Warning ("'{0}' is not a valid Gateway Address." -f $gateway)
                      
                    }

                    $DNSCheck = $dnsserver -match $pattern
                    if ($DNSCheck -eq $false) {
                      Write-Warning ("'{0}' is not a valid DNS Address." -f $dnsserver)
                      
                    }

                   $subnetCheck = $subnetmask -match $subnetPattern
                    if($subnetCheck -eq $false){
                      Write-Warning ("'{0}' is not a valid Subnet Mask." -f $subnetmask)
                    }

                  } until ( $ipCheck -and $gatewayCheck -and $DNSCheck -and $subnetPattern)
                  

                Write-Host "Setting the Interface up now"
                Remove-NetIPAddress -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue
                Remove-NetRoute -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue
                New-NetIPAddress -IPAddress $ipaddress -InterfaceAlias $($interface.ifAlias) -PrefixLength $subnetmask -DefaultGateway $gateway -AddressFamily IPv4
                Start-Sleep -Seconds 2.5
                Set-DnsClientServerAddress -ServerAddresses $dnsserver -InterfaceAlias $($interface.ifAlias)
                Start-Sleep -Seconds 2.5
                Write-Host "Ping Test to 1.1.1.1" 
                ping 1.1.1.1
                break;

        } elseif ($response -eq 'N' -or $response -eq 'n') {
              Write-Host "Checking for Another Adapter"
      
        } else{
              Write-Host "LEARN TO READ"
              exit;
        }    
      }
    Write-Host "There are no other adapters. Closing script"   
} catch {
            $exception = $_.Exception

            while ($null -ne $exception.InnerException){
            $exception = $exception.InnerException
}
            $exception | Format-List * -Force
            Write-Host "ERROR" $exception
}   
        }finally { 
            Write-Host "-----------------------------------JOB COMPLETED-------------------------------------" -ForegroundColor Blue
}