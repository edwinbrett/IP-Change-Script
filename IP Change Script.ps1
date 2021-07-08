<#
This scripts purpose is to change IPs when configuring a VM for Private networking.
Under normal conditions, it should allow the selection of an Ethernet adapter, and change the IP and DNS for it

Made by Edwin Brett, Please reach out via https://Edwinbrett.com if you have any issues.
#>

Write-Host " IP Change Script
===================" -ForegroundColor Blue

Write-Host "Searching for Adapters..." -ForegroundColor Yellow

Get-NetAdapter -Name *

Write-Host "Select from previous list the adapter you would like to configure:"