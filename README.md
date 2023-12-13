README.md
Description:
This repo is to trigger Lambda function whenever a json file is uploaded on S3 bucket.
It takes numbers as a key and sum its values.

Packages:
The Lambda function is written in Python 3.11 and uses the following packages:

logging: Used for logging Lambda events in CloudWatch logs.
json: Used for parsing JSON content.
boto3: The AWS SDK for interacting with AWS resources. 

Commands:
Git :
1. git add .: Add changes to the staging area.
2. git commit -m "message": Commit changes with a descriptive message.
3. git push: Push changes to the remote repository.
4. git pull: Fetch and merge changes from the remote repository.
5. git clone https://github.com/Suprajaa-27/Coding-Challenge.git: Clone this repository.
6. git branch <branch name>: Create a new branch.

Terraform:
1. terraform init: Initialize a Terraform configuration.
2. terraform plan: Create an execution plan.
3. terraform apply: Apply the Terraform configuration.
4. terraform validate: Check the configuration for syntax errors.

Workflows:
There are 2 workflows created for github actions in this repo:
1. auto-pr.yaml - It creates a draft pull requests on pushing code to list of branches like feature/* , chore/* etc. This PR is created against main brach.
2. terraform.yaml - This workflow run a "terraform" job which includes list of steps related to terraform. Workflow is triggered when the code is pushed to "main" branch or any PR is created against it.

To connect to AWS:
Github is connected to my AWS account using OpenID connect. Please find below link for reference.
https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

Lambda:
Module "lambda_s3_trigger" includes terraform files that are required to create a lambda funtion , trigger using s3 bucket , Runtime , function name and handlers that are utilized.

S3:
A S3 bucket is created in which object versioning and object lock is enabled to prevent accidental deletion

Usage example:
Pre-requisites:
1. File name should be "<filename>.json".
2. Should contain "numbers" as Key.
    eg: {
          "numbers": [1, 2, 3, 4, 5]
        }

Manual approach:
Upload a json file with "numbers" as key. Lambda function would calculate sum of it.
CLI
The below command would trigger a lambda function:
aws s3 cp your-file.json s3://your-s3-bucket/












<!--stackedit_data:
eyJoaXN0b3J5IjpbMTMzNzI4MjE2N119
-->