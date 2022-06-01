# In order to use the Github APIs you need to authenticate via an Oauth token. it is best practice to store this token in a secure location that 
# can be called to via the script instead of hard coding it or copy and pasting it from a txt file or local note pad on your PC. 
#NOTE: in this example i am using an Azure Key Vault as my secure method of storing access tokens. You can use many others tools including Google cloud secret manager , AWS key mangament services etc.
#------- IAM roles are used on Key Vaults . Personal/ Service principal account Access to the Azure Key Vault is necessary to be able to store and grab keys from the vault in this script. 

#Step 1 : Log into Azure using Az.Accounts Module commandlets https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.0.0
Write-Host "Connecting to Azure.... a log in prompt should pop up in the browser"

#Step 2: PS command to launch log in to azure --NOTE: if you wish to use a service princple account to log in refer to the following code 
Connect-AzAccount

#Step 3: Set context/scope to the subscription ID where the Azure Key vault is located containg the access token "secret"
Set-AzContext -Subscription "722e159e-d660-45af-ba96-8be2d0c7ff04"

#Step 4: Get the Access Token Secret called "GitHubToken" from the Vault called "TestDevOpsVaultAbby" and store it as a variable called $secret
$secret = Get-AzKeyVaultSecret -VaultName "TestDevOpsVaultAbby" -Name "GitHubToken" -AsPlainText
#---- in powershell syntax the Authorization Header is "Bearer TOKEN_VALUE" .so this next line is adding "Bearer " to the begining of the $secret string value and stored as a variable.
$BearerToken= "Bearer " + $secret

#Step 5: API CREATE A PULL REQUEST in GitHub : METHOD POST--------------------------------
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept", "application/vnd.github.v3+json")
$headers.Add("Authorization", $BearerToken)
$headers.Add("Content-Type", "text/plain")
$body = "{`"title`":`"Doing a great job again`",`"body`":`"Please pull these awesome changes in!`",`"head`":`"agilmore185:Abby-Feature-Test`",`"base`":`"main`"}"
$response = Invoke-RestMethod 'https://api.github.com/repos/agilmore185/AbbyTesting/pulls' -Method 'POST' -Headers $headers -Body $body
$response | ConvertTo-Json

