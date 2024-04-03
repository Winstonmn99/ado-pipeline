# Azure DevOps pipeline

A). Tools used
- Python to build the sample application running on port 5000
- Docker & Docker Hub to containerize and store the image
- Minikube a single node kubernetes environment for to deploy container application
- Terraform to create the ec2, VPC, security groups, subnets and install docker, minikube, kubectl on ec2 instance
- Azure DevOps for automated build & deployment when changes commited to GitHub repository.
- Ansible integrated with ADO pipeline as deployment stack to manage dynamic hosts.

ADO Pipeline - https://dev.azure.com/mabenwinston/ado-pipeline/_build/results?buildId=44&view=logs&j=dd5e8a6e-f0e5-562f-5c8f-6123c6bdff29

![image](https://github.com/mabenwinston/ado-pipeline/assets/72695682/dffab244-183e-486f-a3ab-a71e6a10476b)

