# Updating Azure Functions Using GitHub Action and Zip Deploy

This project is designed to enable an automated method for deploying multiple Azure Functions supporting a single Azure solution. The main goal is to create a workflow that will enable many different functions being maintained in a single repository, supporting a solution to be maintained and deployed using zip deploy.

**Note**
RBAC is used to assign permissions for zip deploy. This means the Github runner is expected to be a virtual machine or Azure Arc enabled server with either a system assigned or managed identity. It is assumed this is already done.

## Onboarding

Onboarding a repository requires some setup in both Azure and the repository.

### Azure Functions

- Enable Soure Control
- Assign RBAC permissions to the Runner Managed Identity

### Github Repository

- Create directory structure

  - Inside repository create "Function" Directory

#### GitHub Runner

- Latest PowerShell 7 version
- Git for Windows

## Making commits

- Direct to feature branch
- Pull request

- Runner RBAC Permissions

## Limitation

- Workflow code diff check between current commit SHA and previous commit SHA will not identify a change if the add or delete of a function is identical between commits
- function
