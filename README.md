# AbbyTesting Readme File for Cardinal Tech Challenge in Powershell.
# This Script is used to demonstrate how to leverage the GitHub APIs to Create , Update, and Merge a pull request in a Git hub public repo called AbbyTesting owned by agilmore185
https://docs.github.com/en/rest/pulls/pulls#list-pull-requests
# PowerShell Integrated Console v2022.5.1

# Assumptions: 
=======================
In order to use the Github APIs you need to authenticate via an Oauth token. it is best practice to store this token in a secure location that 
can be called to via the script instead of hard coding it or copy and pasting it from a txt file or local note pad or credential manager on your PC. 
    1.  git hub.com and log in to your account > settings> developer settings> personal access tokens  https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line
        #NOTE: in this example i am using an Azure Key Vault as my secure method of storing access tokens as a secret. You can use many others tools including Google cloud secret manager , AWS key mangament services etc. 
#------- IAM roles are used on Key Vaults . Personal/ or Service principal account Access to the Azure Key Vault is necessary to be able to store and grab keys from the vault in this script. 
    2. Another assumption is that you already have a Git hub account and that you have created a repositiory inside of it.  https://docs.github.com/en/get-started/signing-up-for-github/signing-up-for-a-new-github-account

# Things to Download:
================================ 
    1. Azure powershell module Az.Accounts to log into and interface with azure key vault https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-8.0.0
    2. Install git https://git-scm.com/download/win
    3. Install vs code or some IDE of your choice https://code.visualstudio.com/Download

# Pre work before running code:
==================================
CLONE REPO TO YOUR LOCAL PC AND CREATE A FEATURE BRANCH:---------------------------------
    1. Clone repo to your local pc https://github.com/git-guides/git-clone
        in a bash terminal or the git cli navigate to documents folder using command "cd documents"
    2. Once you are in the documents folder on your pc type "git clone (url) (name the folder you want to name it)
    3. Now open VS code on your pc and click file open folder and open the newly created folder with your code
    4. In VS code create a new branch by clicking the branch button on the bottom left screen and in the pop up menu click create new branch
    5. Name this Feature branch... i have created a Feature branch already called Abby-Feature-Test
    6. Sync changes to the remote with newly added feature branch

CREATE A PERSONAL ACCESS TOKEN IN GIT HUB TO BE ABLE TO USE THE GIT HUB APIS:---------------------------------
    1.  git hub > settings> developer settings> personal access tokens  https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line
    2. Copy token string value to your clipboard 

CREATE AN AZURE KEY VAULT TO STORE AUTHORIZATION TOKEN IN THAT THE GIT HUB APIS NEED TO USE FOR AUTHORIZATION:--------------------------------
   --NOTE: First you need an azure account  https://azure.microsoft.com/en-us/free/search/#:~:text=Azure%20Event%20Grid%20%20%20%20Azure%20service,%20%20Always%20%2012%20more%20rows%20
   --the subscription ID you get from your azure subscription will need to be used in the script on line 14
    1. use this link to create a key vault and put a secret in it https://docs.microsoft.com/en-us/azure/key-vault/secrets/quick-create-powershell
    2. After you have pasted the personal access token from your clipboard to a secret in azure key vault you can now call it using azure powershell command in the script GithubApiScript line 17

# What does the script do ? 
==================================
This script is a powershell script that is very well commented as to what each line does . There are three Git hub APIs that are used which are able to create a pull
request in github, edit an existing open pull request (specifically it updated the body of the request with the pullnumber), and merge that pull request on command. https://docs.github.com/en/rest/pulls/pulls#list-pull-requests . In this script it is demonstrating how to create a pull request , update the body of it with the pull number of the request, and then merge it. Because powershell is easier than bash when it comes to parsing JSON output , i used POSTMAN to convert the following cURL commands below into Powershell syntax. The powershell script GithubApiScript
is utilizing these APIS written in powershell. 
# Here are the Curl Commands that were posted into Post man to get the powershell syntax for creating the script GithubApiScript  https://www.postman.com/use-cases/api-testing-automation/
curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token TOKENSTRING" \
  https://api.github.com/repos/OWNER/REPO/pulls \
  -d '{"title":"NewRequest","body":"Please pull these awesome changes in!","head":"agilmore185:Abby-Feature-Test","base":"main"}'

curl \
  -X PATCH \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token TOKENSTRING" \
  https://api.github.com/repos/OWNER/REPO/pulls/PULLNUM \
  -d '{"title":"New Title again","body":"updated body","state":"open","base":"main"}'


  curl \
  -X PUT \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: token TOKENSTRING" \
  https://api.github.com/repos/OWNER/REPO/pulls/PULLNUM/merge

# Run Instructions: 
======================
    1. Add a comment here and click file save
    2. Stage the change
    3. commit the change and add a commit comment
    4. sync the changes to the remote and now you are ready to run the GithubApiScript Powershell script to create a pull request for your change!

  #adding a change
  #add another change
  #adding another change at 9:54 pm 6/1/2022
  #adding a comment on 6/2/2022
  testing change
  #testing demo 

  