# In order to use the Github APIs you need to authenticate via an Oauth token. it is best practice to store this token in a secure location that 
# can be called to via the script instead of hard coding it or copy and pasting it from a txt file or local note pad or credential manager on your PC. 
#NOTE: in this example i am using an Azure Key Vault as my secure method of storing access tokens as a secret. You can use many others tools including Google cloud secret manager , AWS key mangament services etc.
#------- IAM roles are used on Key Vaults . Personal/ or Service principal account Access to the Azure Key Vault is necessary to be able to store and grab keys from the vault in this script. 

#Step 1 : Log into Azure using Az.Accounts Module commandlets https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.0.0
    Write-Host "Connecting to Azure.... a log in prompt should pop up in the browser"

#Step 2: PS command to launch log in to azure --NOTE: if you wish to use a service princple account to log in refer to the following code 
    Connect-AzAccount

#Step 3: Set context/scope to the subscription ID where the Azure Key vault is located containg the access token "secret"
    Write-Host "Connecting to Azure Subscription and getting Auth Token needed from Azure Key Vault to pass to Authorization Header in Github API......."
        Set-AzContext -Subscription "722e159e-d660-45af-ba96-8be2d0c7ff04"

#Step 4: Get the Access Token Secret called "GitHubToken" from the Vault called "TestDevOpsVaultAbby" and store it as a variable called $secret
#--------- how to fix execution policy if this fails https://stackoverflow.com/questions/64633727/how-to-fix-running-scripts-is-disabled-on-this-system
    $secret = Get-AzKeyVaultSecret -VaultName "TestDevOpsVaultAbby" -Name "GitHubToken" -AsPlainText
    #---- in powershell syntax the Authorization Header is "Bearer TOKEN_VALUE" .so this next line is adding "Bearer " to the begining of the $secret string value and stored as a variable.
            $BearerToken= "Bearer " + $secret

#Step 5: ---------------API CREATE A PULL REQUEST in GitHub : METHOD POST--------------------------------
    Write-Host "CALLING GIT HUB API TO CREATE A PULL REQUEST.........."
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Accept", "application/vnd.github.v3+json")
        $headers.Add("Authorization", $BearerToken)
        $headers.Add("Content-Type", "text/plain")
        $body = "{`"title`":`"Doing a great job again`",`"body`":`"Please pull these awesome changes in!`",`"head`":`"agilmore185:Abby-Feature-Test`",`"base`":`"main`"}"
            $response = Invoke-RestMethod 'https://api.github.com/repos/agilmore185/AbbyTesting/pulls' -Method 'POST' -Headers $headers -Body $body
            $response | ConvertTo-Json

#Step 6: Now that the pull request has been created , I am going to demonstrate how you can get information from the output ... in this example lets get the Pull request number
    Write-Host "Getting pull request number and assigning it to a variable called pullnum"
        $pullnum= $response.number

#Step 7: ---------------API UPDATE A PULL RQUEST in GitHub : METHOD PATCH--------------------------------
    Write-Host "Demonstrating how to update a pull request body via the API......."
        $url =" https://api.github.com/repos/agilmore185/AbbyTesting/pulls/" + $pullnum
        write-output $url
            $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
            $headers.Add("Accept", "application/vnd.github.v3+json")
            $headers.Add("Authorization", $BearerToken)
            $headers.Add("Content-Type", "text/plain")
            $body = "{`"title`":`"Doing it again`",`"body`":`" updating the body to current pull num which is : $pullnum`",`"state`":`"open`",`"base`":`"main`"}"
                $response = Invoke-RestMethod -Uri $url  -Method 'PATCH' -Headers $headers -Body $body
                $response | ConvertTo-Json


#Step 8: ---------------API MERGE PULL RQUEST in GitHub : METHOD PUT--------------------------------
    Write-Host "Building URL for merging to pass to API......."
        $mergeurl = $url + "/merge"
        write-output $mergeurl

        Write-Host "MERGING......."
            $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
            $headers.Add("Accept", "application/vnd.github.v3+json")
            $headers.Add("Authorization", $BearerToken)
            $body = ""
                $response = Invoke-RestMethod -Uri $mergeurl -Method 'PUT' -Headers $headers -Body $body
                $response | ConvertTo-Json