# Coding-Challenge
Description:
This repo is to trigger Lambda function whenever a json file is uploaded on S3 bucket.
It takes numbers as a key and sum its values.

Packages:
Lambda function is wiritten using. It uses version Python 3.11
It needs logging and json packages to be utilized to log the lambda events in Cloud watch logs when there is a json file.
Boto3 is  AWS SDK that allows to create,update,delete resources on AWS. 

Commands:
Git :
1. git add .
2. git commit -m "message"
3. git push
4. git pull
5. git clone https://github.com/Suprajaa-27/Coding-Challenge.git
6. git branch <branch name>

Terraform:
1. terraform init
2. terraform plan
3. terraform apply
3. terraform validate

Usage example:
Pre-requisites:
1. File name should be "<filename>.json".
2. Should contain "numbers" as Key.
Manual approach:
Upload a json file with "numbers" as key. Lambda function would calculate sum of it.
CLI
The below command would trigger a lambda function:
aws s3 cp your-file.json s3://your-s3-bucket/

To connect to AWS:
Github is connected to my AWS account using OpenID connect. Please find below link for reference.
https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services

Lambda:
Module "lambda_s3_trigger" includes terraform files that are required to create a lambda funtion , trigger using s3 bucket , Runtime , function name and handlers that are utilized.











