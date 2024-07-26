#!bin/bash
#
###############################################
#
#Author: Aashutosh Dahal
#
#Created: 7/25/2024
#
#Version: V1
#
#This script displays the info about the aws resources used by company. Added to crontab
#
###############################################
#
#
echo "List of Index of Aws EC2 instances with their Instance-id"
aws ec2 describe-instances | jq '.Reservations[].Instances[] | {AmiLaunchIndex, InstanceId, InstanceType, KeyName, PublicIpAddress}'

echo "List of s3 buckets"
aws s3 ls

echo "List of IAM user"
aws iam list-users

echo "List of lamba function:"
aws lambda list-functions

echo "Daily cost report"
aws ce get-cost-and-usage --time-period Start=$(date -d "yesterday" +"%Y-%m-%d"),End=$(date +"%Y-%m-%d") --metric "BlendedCost" "UnblendedCost" "UsageQuantity" --granularity DAILY

