## 🚀 Project Summary

This Terraform project automates the deployment of a scalable, highly available AWS infrastructure. It provisions:

- A custom VPC with public subnets in multiple Availability Zones
- Internet Gateway and Route Tables for public access
- A Security Group allowing HTTP and SSH traffic
- An EC2 Launch Template with user-defined configurations
- An Auto Scaling Group (ASG) to manage instances dynamically
- A Network Load Balancer (NLB) to distribute traffic across instances
- An IAM Role and Instance Profile granting EC2 access to an S3 bucket

The setup ensures high availability, fault tolerance, and easy scalability for cloud-native applications.

---

## 🔧 Features

- **VPC** with two public subnets
- **Internet Gateway** and **Route Tables**
- **Security Group** with SSH (22) and HTTP (80)
- **Key Pair** for EC2 instance access
- **IAM Role and Instance Profile** with permissions to access S3
- **S3 Bucket** for data access
- **Launch Template** for EC2 instance configuration
- **Auto Scaling Group** to maintain healthy instances
- **Network Load Balancer** for distributing traffic


## 📄 Files & Modules

| File               | Purpose                                               |
|--------------------|-------------------------------------------------------|
| `provider.tf`       | AWS provider and region setup                        |
| `vpc.tf`            | VPC, subnets, route tables, and IGW configuration    |
| `security.tf`       | Security group for HTTP & SSH access                |
| `keypair.tf`        | EC2 key pair using your SSH public key              |
| `s3.tf`             | S3 bucket resource                                   |
| `iam.tf`            | IAM role, instance profile, and S3 policy           |
| `ec2_launch_template.tf` | EC2 config with userdata and IAM profile    |
| `asg.tf`            | Auto Scaling Group configuration                    |
| `nlb.tf`            | Network Load Balancer with target group             |
| `variables.tf`      | Input variables for customization                    |
| `outputs.tf`        | Useful outputs (e.g., NLB DNS)                      |

---

## 📐 Simplified Architecture

            ┌─────────────┐
            │   S3 Bucket │
            └─────┬───────┘
                  │
          ┌───────▼────────┐
          │  IAM Role +    │
          │ Instance Profile │
          └───────┬────────┘
                  │
        ┌─────────▼──────────┐
        │    Auto Scaling    │
        │     EC2 Group      │
        └──────▲──────▲──────┘
               │      │
       ┌───────┘      └───────┐
       ▼                     ▼
┌────────────┐       ┌────────────┐
│  Subnet A  │       │  Subnet B  │
└─────┬──────┘       └─────┬──────┘
      ▼                    ▼
   ┌──────────────────────────┐
   │   Network Load Balancer │
   └──────────────────────────┘



## 🧪

                      

