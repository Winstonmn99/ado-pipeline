# Azure DevOps pipeline

A). Tools used
- Python to make the sample app
- Docker & Docker Hub to containerize and store the image
- Minikube a single node kubernetes environment for to deploy container application
- Terraform to create the ec2, VPC, security groups, subnets and install docker, minikube on ec2
- Azure DevOps for automated build & deployment when changes commited to GitHub repo.
- Ansible integrated with ADO pipeline as deployment stack to manage dynamic hosts.
