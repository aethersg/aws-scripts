#!/usr/bin/env bash

# install aws cli first
# brew install awscli

#create file to store it in

now=$(date +"%d_%m_%Y")

for region in `aws ec2 describe-regions --output text | cut -f3`
do
     echo -e "\n Instances in region:'$region'" >> "Instances_$now.txt"
     aws ec2 describe-instances --query "Reservations[*].Instances[*].{IP:PublicIpAddress,ID:InstanceId,Type:InstanceType,State:State.Name,Name:Tags[0].Value}" --output=table --region $region >> "Instances_$now.txt"
done
echo -e "\n Done please check Instances_$now.txt"