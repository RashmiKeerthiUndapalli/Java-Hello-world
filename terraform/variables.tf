variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "hello-devops-eks"
}

variable "vpc_cidr" {
  description = "CIDR block for the EKS VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the EKS subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "eks_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27"
}

variable "node_instance_type" {
  description = "EC2 instance type for EKS worker nodes"
  type        = string
  default     = "t3.medium"
}

variable "node_group_desired_size" {
  description = "Desired size of the EKS managed node group"
  type        = number
  default     = 2
}

variable "node_group_min_size" {
  description = "Minimum node count for the EKS managed node group"
  type        = number
  default     = 1
}

variable "node_group_max_size" {
  description = "Maximum node count for the EKS managed node group"
  type        = number
  default     = 3
}

variable "node_group_capacity_type" {
  description = "Capacity type for the EKS node group"
  type        = string
  default     = "ON_DEMAND"
}

variable "image" {
  description = "Docker image to deploy in Kubernetes"
  type        = string
  default     = "your-registry.example.com/hello-devops:latest"
}
