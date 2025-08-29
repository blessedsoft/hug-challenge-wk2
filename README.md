# Multi-Environment Web App Infra with Auto-Scaling (AWS + Terraform)

## Project Brief
Production-ready, autoscaling web stack with **separate `dev` and `prod` environments**. 

Project Documentation: https://www.notion.so/Step-by-Step-Guide-Multi-Environment-WebApp-Infrastructure-with-Terraform-25d73770dae980dc8245f7047f137389?source=copy_link



## Architecture
<img width="356" height="356" alt="Architecture Diagram" src="https://github.com/user-attachments/assets/5419f763-7dc6-4db4-b7dc-01a469bd7484" />

**Traffic flow:** Internet → **ALB** → **Target Group** → **EC2 (ASG)** → **RDS**  
**Security:** SGs restrict inbound (HTTP to ALB, MySQL from app SG only).

---

## What Terraform Creates
- **VPC** with 2× public + 2× private subnets (multi-AZ), **IGW**, **NAT**, route tables  
- **ALB** + **Target Group** + **Listener (HTTP 80)**  
- **Launch Template** + **Auto Scaling Group** (EC2 in private subnets)  
- **RDS MySQL** + **DB Subnet Group** + backups enabled  
- **Security Groups** for web tier and DB tier  
- **Outputs** (ALB DNS, DB endpoint, ASG name, etc.)

---
