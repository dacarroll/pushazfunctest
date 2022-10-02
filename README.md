# Updating Azure Functions Using GitHub Action and Zip Deploy

This project is designed to enable an automated method for deploying multiple Azure Functions supporting a single Azure solution. The main goal is to create a workflow that will enable many different functions being maintained in a single repository, supporting a solution to be maintained and deployed using zip deploy.

>**Note** RBAC is used to assign permissions for zip deploy. This means the Github runner is expected to be a virtual machine or Azure Arc enabled server with either a system assigned or managed identity. It is assumed this is already done.

## Onboarding PowerShell Function Apps

Onboarding a Azure Function app into the repository requires a few steps both within Azure and in the repository. The steps below are the *minimum* steps for onboarding an application. Your specific Function may require additional files or configurations to properly work within Azure.

1. Create the function App directory within **Functions** section of the repository
    > e.g. Onboarding a new function app called avdreportsync

    ```PowerShell
    cd ./functions
    mkdir avdreportsync
    ./functions
    ├── avdmetrics
    │   ├── function1
    │   ├── function2
    ├── avdreportsync
    ```
  
    The above example shows onboarding a new function app by creating a directory with the app name at the root of the functions directory within the repository.

2. Next involves adding all files needed for your function app to work. The required files will depend on what your project needs. See [Azure Functions](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-vs-code-powershell) for PowerShell specific documentation on setting up your function or adding modules to your project.

3. Configure your function app to run from a package using the application setting **WEBSITE_RUN_FROM_PACKAGE**. There are multiple ways to do this using the portal, PowerShell, or CLI. Use whatever you prefer.

    ```PowerShell
    Update-AzFunctionAppSetting -Name avdreportsync -ResourceGroupName MyResourceGroupName -AppSetting @{"WEBSITE_RUN_FROM_PACKAGE" = "1"}
    ```

    See [Application Settings Reference](https://learn.microsoft.com/en-us/azure/azure-functions/functions-app-settings) for other settings.

4. After modifying your function app and adding all needed files your newly onboarded project may look like below.

    ```PowerShell
    ./functions
    ├── avdreportsync
    │   ├── function.json
    │   └── run.ps1
    │── Modules
    │   ├── custommodule
    │   └── custommodule.psm1
    ├── profile.ps1
    └── requirements.psd1
    ```

    It is now ready to commit and publish to Azure via the trigger workflow. For the process check [Making Commits](#Making Commits "Goto Making Commits" )

## GitHub Runner

The GitHub runner that is executing the workflow requires the following RBAC permissions at a minumum to execute zipdeploy

    Microsoft.Web/sites/publish/Action
    microsoft.web/sites/slots/deployments/write

- Latest PowerShell 7 version
- Git for Windows

## Making commits <a name="making_commits"></a>

- Direct to feature branch
- Pull request

- Runner RBAC Permissions

## Limitation

- Workflow code diff check between current commit SHA and previous commit SHA will not identify a change if the add or delete of a function is identical between commits
