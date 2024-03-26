# Get an access token for managed identities for Azure resources
$response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -Headers @{Metadata="true"}
$content = $response.Content | ConvertFrom-Json
$access_token = $content.access_token
echo "The managed identities for Azure resources access token is $access_token"


$secret = (Invoke-RestMethod -Uri https://esywps.vault.azure.net/secrets/TEST/7ed1793bb66b4a5da9e93d1b05eef9f1?api-version=2016-10-01 -Method GET -Headers @{Authorization="Bearer $access_token"}).value
(Invoke-RestMethod -Uri https://esywps.vault.azure.net/secrets/TEST/7ed1793bb66b4a5da9e93d1b05eef9f1?api-version=2016-10-01 -Method GET -Headers @{Authorization="Bearer $access_token"}).value >> C:\agents\mylittlescret.txt