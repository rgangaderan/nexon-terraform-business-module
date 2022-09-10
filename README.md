# Nexon Buniness Layer
This module will use to create real business requirement, based on technical need.
If we need to create any infrastructure and application related with business need we will use this module to call technology module located in https://github.com/rgangaderan/nexon-terraform-tech-module

This business module will also create small resources.

EX: if you need to create Autoscaling Group with Application Load Balancer you will call the main modules from technology layer in https://github.com/rgangaderan/nexon-terraform-tech-module

And other supporting modules such as AMI, IAM, Security Group only will create in this Business Layer. The reason behind creating child modules in Business Layer is, because this child modules have only specific values that will unique to Business Layer

Example: AMI ID that can be different from project to project. So, you can create AMI.tf in business layer and customize based on your need instead creating them on Main technology layer. 

In this below Image main.tf has the main root module called from technology GitHub repo and other child supporting resources such as ami.tf, iam.tf security-group.tf will creating in this module it self.

<img width="1188" alt="image" src="https://user-images.githubusercontent.com/36160986/187963833-326ce065-9a7c-4907-86bc-9dd0d823090b.png">


<!-- END_TF_DOCS -->

