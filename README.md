# DevOps Java Hello World Project

A minimal DevOps project using:
- Java Spring Boot web app
- Docker container
- Kubernetes deployment
- Terraform-managed Kubernetes resources
- Jenkins pipeline for build and deployment

## Project structure

- `pom.xml` - Maven build file
- `src/main/java/com/example/demo/Application.java` - Spring Boot runnable app
- `src/main/java/com/example/demo/HelloController.java` - HTTP endpoint returning Hello World
- `src/main/resources/application.properties` - application config
- `Dockerfile` - build Docker image
- `Jenkinsfile` - Jenkins pipeline for build, image, and deploy
- `k8s/deployment.yaml` - Kubernetes Deployment manifest
- `k8s/service.yaml` - Kubernetes Service manifest
- `terraform/main.tf` - Terraform configuration for Kubernetes provider and resources
- `terraform/variables.tf` - Terraform variables
- `terraform/outputs.tf` - Terraform outputs

## Prerequisites

Install these tools on your machine:
1. Java 17 or newer
2. Maven
3. Docker
4. AWS CLI
5. kubectl
6. Terraform
7. Jenkins server
8. AWS account with permissions for EKS, VPC, IAM, EC2, and ECR

## AWS/EKS setup

This project now uses Amazon EKS for the Kubernetes cluster. The Terraform configuration creates:
- AWS VPC and subnets
- EKS cluster
- EKS managed node group
- Kubernetes namespace, Deployment, and Service inside the cluster

## Quick start

1. Build the Java app:
   ```bash
   mvn clean package
   ```
2. Build the Docker image:
   ```bash
   docker build -t hello-devops:latest .
   ```
3. Push the image to a registry. For AWS ECR, use:
   ```bash
   aws ecr create-repository --repository-name hello-devops || true
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com
   docker tag hello-devops:latest <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/hello-devops:latest
   docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/hello-devops:latest
   ```
   Replace `<aws_account_id>` with your AWS account ID and update the region if needed.
4. Configure the Terraform image variable before applying:
   ```bash
   cd terraform
   terraform init
   terraform apply -var='image=<aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/hello-devops:latest'
   ```
5. After Terraform applies, update your kubeconfig for EKS:
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name hello-devops-eks
   ```
6. Verify the Kubernetes cluster:
   ```bash
   kubectl get nodes
   kubectl get svc -n hello-devops
   ```

## Jenkins Pipeline

Use the included `Jenkinsfile` on your Jenkins job. It builds the app, builds the Docker image, pushes it to a registry, and deploys the Kubernetes manifests.

### Jenkins notes for EKS

- Set `REGISTRY` in `Jenkinsfile` to your ECR repository domain, for example:
  `123456789012.dkr.ecr.us-east-1.amazonaws.com`
- Create Jenkins credentials with ID `docker-registry-creds` for the ECR login.
- Ensure the Jenkins agent has AWS credentials or access to the EKS cluster.
- If deploying from Jenkins to EKS, make sure `kubectl` and AWS CLI are installed on the agent.
