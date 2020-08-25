# Instructions

## Prerequisites
1. Free tier GCP Account
2. Free tier AWS account
2. Public github repository

##Background
Define variables with your GCP account information
* TF_VAR_billing_account
* TF_VAR_org_id
* TF_VAR_parent (format organizations/org_id)
* To deploy on GCP use Terraform v0.12.29

#Roles needed on GCP account
* Cloud SQL Admin
* Compute Network Admin
* Folder Admin
* Organization Administrator


## Inputs
1. Apply this terraform code to GCP account and will create:
* GCE Instace with Wordpress on it
* CloudSQL DB where Wordpress will connect
* REDIS Cache which will be used by Wordpress
* VPC
* Firewall Configurations

2. Using output IP from Terraform, make a screenshot of running wordpress

## Task
Using Infrastructure as a Code (use language and tools of your choice) deploy same stack to AWS

1. Appliction runs on EC2 instance
2. Database runs on a managed service
3. Redis configured and serving cache to Application
4. All VPC Configurations

## Output
1. Put the code to github repositry under task3/ folder
2. Put the screenshot proving (screenshot1.png) that application runs on AWS into the folder 
