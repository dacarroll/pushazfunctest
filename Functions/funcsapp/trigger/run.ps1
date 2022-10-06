using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)

# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$name = $Request.Query.Name
if (-not $name) {
    $name = $Request.Body.Name
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($name) {
    $body = "Hello, $name. This HTTP triggered function executed successfully."
}
#No real updates
if (!(Test-Path $env:Home\Data\log.txt)) {
    Write-Output "First Run experience collecting all logs"
    New-Item $env:Home\Data\Log.txt
}
else {
    Write-Output "Checking current time and last success"
    Get-Content $env:Home\Data\Log.txt
}

$LogText = [pscustomobject]@{
    LastRun = [datetime]::UtcNow.ToString('o')
    CurrentRun = [datetime]::UtcNow.ToString('o')
}

if ($success) {
    $LogText | Export-Csv -Path $env:Home\Data\Log.txt
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body       = $body
})