# nexon-terraform-business-module

## Iteration 01.

Application hosted on EC2 Autoscaling Group with AWS ClassicLoadBalancer.

This Application has a static web page and artifact stored in S3 bucket.

s3://aritifacts-nexon-app/index.html


We have Separate CI pipeline running in GitHub Action on 
https://github.com/rgangaderan/nexon-application-CICD/blob/main/.github/workflows/ci-static-webapp-elb.yml


The above workflow will copy the artifact (Index.html) to s3 bucket during the CI process and when we deploy this module. User_data will download the index.html to var/www/html and run the instance based on max nad min count defined in Autoscaling Group, it will also creating a Launch Template with all the information related to EC2

```
#!/bin/bash

# Update and install apache web server
sudo apt-get update && sudo apt-get install apache2 -y

# Instanll AWS CLI to access S3 Bucket for copy artifacts #
sudo apt install awscli -y
sudo -i

# Copy artifact for web application #

aws s3 cp s3://aritifacts-nexon-app/index.html /var/www/html/
```
![image](https://user-images.githubusercontent.com/41107404/189475619-e755855e-c75b-46c4-8cf8-e3badc0d0a5a.png)

This module will use to create real business requirement, based on technical need.
If we need to create any infrastructure and application related with business need we will use this module to call technology module located in https://github.com/rgangaderan/nexon-terraform-tech-module

This business module will also create small resources.

EX: if you need to create Autoscaling Group with Application Load Balancer you will call the main modules from technology layer in https://github.com/rgangaderan/nexon-terraform-tech-module

And other supporting modules such as AMI, IAM, Security Group only will create in this Business Layer. The reason behind creating child modules in Business Layer is, because this child modules have only specific values that will unique to Business Layer

Example: AMI ID that can be different from project to project. So, you can create AMI.tf in business layer and customize based on your need instead creating them on Main technology layer. 

In this below Image main.tf has the main root module called from technology GitHub repo and other child supporting resources such as ami.tf, iam.tf security-group.tf will creating in this module it self.

<img width="1188" alt="image" src="https://user-images.githubusercontent.com/36160986/187963833-326ce065-9a7c-4907-86bc-9dd0d823090b.png">


<!-- END_TF_DOCS -->

