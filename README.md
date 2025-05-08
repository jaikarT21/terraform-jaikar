
# 🚀 Terraform AWS Autoscaling Infrastructure

This project provisions a dynamic, scalable AWS architecture using Terraform.

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

## 📐 Architecture

                                   ┌────────────────────┐
                                   │     S3 Bucket      │
                                   │  (tf-s3 bucket)    │
                                   └────────┬───────────┘
                                            │
                                            ▼
                                  ┌────────────────────┐
                                  │   IAM Role +       │
                                  │ Instance Profile   │
                                  └────────┬───────────┘
                                           │
                                           ▼
┌───────────────────────────────────────────────────────────────────────┐
│                             AWS VPC (tf-vpc)                          │
│                                                                       │
│  ┌────────────────────┐                    ┌────────────────────┐     │
│  │  Public Subnet A   │                    │  Public Subnet B   │     │
│  └────────────────────┘                    └────────────────────┘     │
│        │                                            │                 │
│        ▼                                            ▼                 │
│  ┌───────────────┐                          ┌───────────────┐         │
│  │   EC2 (ASG)    │                          │   EC2 (ASG)    │         │
│  └───────────────┘                          └───────────────┘         │
│         ▲                                             ▲               │
│         │                                             │               │
│         └──────────────┐         ┌────────────────────┘               │
│                        ▼         ▼                                    │
│               ┌───────────────────────────┐                           │
│               │   Network Load Balancer   │                           │
│               │         (tf-nlb)          │                           │
│               └───────────────────────────┘                           │
│                                                                       │
└───────────────────────────────────────────────────────────────────────┘


---

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

## 🧪

                      

