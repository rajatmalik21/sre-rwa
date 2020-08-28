# Instructions

## Prerequisites
1. Free tier AWS account
2. Free tier GCP account
3. Github account

## Inputs
1. Working terraform code deploying application to GCP cloud

## Task
Using Infrastructure as a Code (use language and tools of your choice) deploy the full stack of the application in AWS preserving static content and logs.


### Requirements
- EC2 for WordPress and Redis instances
- Database runs on a managed service
- Install WordPress 5.0.10 or newer
- Run PHP 7 or newer
- New dedicated virtual private network
- Allow SRE/DevOps to connect via SSH to EC2 instance for troubleshooting
- Redis server listening on the default port and with no authentication

## Output
1. Put the code to your personal github repository under task3/ folder and share the link
2. Put the screenshot proving (screenshot1.png) that application runs on AWS (Wordpress Admin Config Page)
3. Make sure to share the terraform.tfstate securely after deployment succeed

# Application details

![Solution Archicture](images/Diagram.png)

This is the architecture design for solution implementation. It is designed to be non HA and single datanceter on porpuse.

## Components
The following components compose the architecture:
- One virtual private network and its subnets
- One virtual machine for web
- One virtual machine for caching
- One MySQL database as a service

## Deploy GCP environment 

### Prerequisites
1) Free tier GCP Account with Organization [enabled](https://cloud.google.com/resource-manager/docs/creating-managing-organization#acquiring)
1) Terraform 0.12.29
1) Google Cloud SDK (gcloud)

### GCP Roles
* Cloud SQL Admin
* Compute Network Admin
* Folder Admin
* Project Creator

These roles must be assigned at organization level for sake of simplicity.

### Shell variables

Export variables with your GCP account information
* TF_VAR_billing_account
* TF_VAR_org_id
* TF_VAR_parent (format organizations/org_id)

### Deployment

Perform the following steps to deploy application to GCP:
```
$ gcloud init
$ MY_EMAIL=you@domain.com
$ export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.config/gcloud/1)$ cy_credentials/$MY_EMAIL/adc.json
$ terraform init
$ terraform plan
$ terraform apply
```
