using namespace System.Net

# Input bindings are passed in via param block.
param($LogData, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
Write-Host "LogData"
$LogData

Write-Host "TriggerMetadata"
$TriggerMetadata

$body = $LogData.Body
$body
$ctx = New-AzStorageContext -ConnectionString $env:AzureWebJobStorage

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body       = $body
})