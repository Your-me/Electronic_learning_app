# Terraform AWS Infrastructure Project

This project uses Terraform to provision a comprehensive AWS infrastructure, including a VPC, PostgreSQL RDS, Route 53, Amazon Certificate Manager, Application Load Balancer, and Elastic Container Service (ECS). Jenkins is used for continuous integration and deployment.

## Table of Contents

- [Project Overview](#project-overview)
- [Infrastructure Components](#infrastructure-components)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
- [Jenkins Integration](#jenkins-integration)

## Project Overview

This project aims to automate the deployment of a scalable and secure AWS infrastructure using Terraform. The infrastructure supports containerized applications running on ECS, with high availability and secure access through an Application Load Balancer and SSL certificates managed by Amazon Certificate Manager.

## Infrastructure Components

- **VPC**: A Virtual Private Cloud to host all resources, with public and private subnets.
- **PostgreSQL RDS**: A managed relational database service for storing application data.
- **Route 53**: A scalable DNS web service for domain management.
- **Amazon Certificate Manager (ACM)**: Manages SSL/TLS certificates for secure communication.
- **Application Load Balancer (ALB)**: Distributes incoming application traffic across multiple targets.
- **Elastic Container Service (ECS)**: Orchestrates Docker containers for application deployment.

## Project Structure

- **modules/**: Contains reusable Terraform modules for each infrastructure component.
- **environments/**: Contains environment-specific configurations (e.g., dev, staging, prod).
- **jenkins/**: Contains Jenkins pipeline configuration.
- **variables.tf**: Defines input variables for the project.
- **outputs.tf**: Defines output values for the project.

## Prerequisites

- **Terraform**: Install Terraform (>= 1.0).
- **AWS CLI**: Install and configure the AWS CLI with appropriate credentials.
- **Jenkins**: Set up Jenkins with necessary plugins for Terraform and AWS.

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/terraform-aws-infrastructure.git
   cd terraform-aws-infrastructure
   cd environments/dev
terraform init
terraform plan
terraform apply
## Usage

- **Deploying Changes**: After making changes to the Terraform configuration, use the following commands to review and apply updates to your infrastructure:
  ```bash
  terraform plan
  terraform apply
## Destroying Infrastructure

If you need to remove all the resources created by this Terraform project, you can do so by using the `terraform destroy` command. This command will prompt you to confirm the destruction of the resources, ensuring that you do not accidentally delete your infrastructure.

### Steps to Destroy Infrastructure

1. **Navigate to the Environment Directory**:
   Ensure you are in the correct environment directory where your Terraform state is managed. For example, if you are working in the development environment, navigate to:
   ```bash
   cd environments/dev
   terraform destroy
## Jenkins Integration

This project leverages Jenkins for continuous integration and deployment, automating the process of applying Terraform configurations and managing infrastructure changes on AWS.

### Setting Up Jenkins Pipeline

1. **Jenkinsfile**:
   - The `Jenkinsfile` located in the `jenkins/` directory defines the CI/CD pipeline. It includes stages for initializing Terraform, planning changes, and applying configurations.

2. **Create a Jenkins Pipeline Job**:
   - **Access Jenkins**: Log in to your Jenkins instance.
   - **New Item**: Click on "New Item" to create a new job.
   - **Pipeline**: Select "Pipeline" and provide a name for your job.
   - **Source Code Management**: Configure the job to use the repository containing this project.
   - **Pipeline Script**: Set the pipeline to use the `Jenkinsfile` from the repository.

3. **Configure Environment Variables**:
   - Ensure Jenkins has access to necessary environment variables and AWS credentials. This can be done by:
     - **Credentials**: Adding AWS credentials in Jenkins under "Manage Jenkins" -> "Manage Credentials".
     - **Environment Variables**: Configuring any additional environment variables required by the Terraform scripts.

4. **Run the Pipeline**:
   - Trigger the pipeline manually or configure it to run automatically based on changes to the repository.
   - Monitor the pipeline execution through the Jenkins interface to ensure successful deployment.
   - 

5. **Review Pipeline Logs**:
   - Check the logs for each stage in the Jenkins pipeline to verify that Terraform commands are executed successfully and that the infrastructure is deployed as expected.

### Benefits of Jenkins Integration

- **Automation**: Automates the deployment process, reducing manual effort and the potential for human error.
- **Consistency**: Ensures consistent application of Terraform configurations across different environments.
- **Scalability**: Easily scale the infrastructure by adjusting Terraform configurations and rerunning the pipeline.
- **Visibility**: Provides clear visibility into the deployment process through Jenkins logs and dashboards.

By integrating Jenkins with this Terraform project, I was able to streamline the deployment and management of my AWS infrastructure, ensuring efficient and reliable operations.     
