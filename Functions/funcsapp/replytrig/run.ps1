using namespace System.Net

# Input bindings are passed in via param block.
param($Request, $TriggerMetadata)
#small change
# Write to the Azure Functions log stream.
Write-Host "PowerShell HTTP trigger function processed a request."

# Interact with query parameters or the body of the request.
$names = $Request.Query.Name
if (-not $names) {
    $names = $Request.Body.Name
}

$body = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

if ($names) {
    $body = "Hello, $names. This HTTP triggered function executed successfully."
}

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = [HttpStatusCode]::OK
    Body       = $body
})