# Multi-Environment Web App Infra with Auto-Scaling (AWS + Terraform)

## Project Brief
Production-ready, autoscaling web stack with **separate `dev` and `prod` environments**. 

**Key goals**
- Clean, modular Terraform (`networking`, `compute`, `database`)
- Separate envs: `environments/dev` and `environments/prod`
- Auto-scaling based on demand (CPU), fronted by an ALB
- Clear tagging per environment + configurable VPC CIDR blocks

---

## Architecture
![alt text](image.png)

```

**Traffic flow:** Internet → **ALB** → **Target Group** → **EC2 (ASG)** → **RDS**  
**Security:** SGs restrict inbound (HTTP to ALB, MySQL from app SG only).

---

## What Terraform creates
- **VPC** with 2× public + 2× private subnets (multi-AZ), **IGW**, **NAT**, route tables  
- **ALB** + **Target Group** + **Listener (HTTP 80)**  
- **Launch Template** + **Auto Scaling Group** (EC2 in private subnets)  
- **RDS MySQL** + **DB Subnet Group** + backups enabled  
- **Security Groups** for web tier and DB tier  
- **Outputs** (ALB DNS, DB endpoint, ASG name, etc.)

---

## Repository Structure

```
terraform-multi-environs-webapp-infra/
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── database/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── environments/
    ├── dev/
    │   ├── main.tf           # provider + module wiring for dev
    │   ├── variables.tf      # variable declarations
    │   └── terraform.tfvars  # dev values (region, tags, vpc_cidr, asg, db creds)
    └── prod/
        ├── main.tf
        ├── variables.tf
        └── terraform.tfvars
```

> Each environment folder is self-contained. Running Terraform there only affects that env.

---

---

## Quick Start

### 0) Prereqs
- Terraform Installed
- AWS account with permissions for VPC/EC2/ELB/RDS/CloudWatch/IAM  
- AWS creds available via **profile** or **env vars**
  - Profile:
    ```bash
    aws configure --profile myprofile
    ```
  - Or env vars:
    ```bash
    export AWS_ACCESS_KEY_ID=...
    export AWS_SECRET_ACCESS_KEY=...
    export AWS_DEFAULT_REGION=us-east-1
    ```

### 1) Dev environment deploy
```bash
cd environments/dev

# (optional) set secrets as env var instead of tfvars file
# export TF_VAR_db_password="DevPass123!"

terraform init
terraform plan
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

**What you’ll see on success**
- `alb_dns_name` → open in a browser to hit the app (simple Apache page from user data)  
- `db_endpoint` → host for MySQL connections  
- `autoscaling_group_name` → for inspection & scaling

### 2) Prod environment deploy
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

### 3) Scale test (dev or prod)
- Generate CPU load on one instance (e.g., small stress loop) or use a load tester (Locust/k6) to hit the ALB.
- Verify **Target Group health**, **ASG activity**, **Instances count** increases.
- (Optional) Add CloudWatch CPU alarms + scaling policies if not already configured.

### 4) Tear down (clean up)
From the env folder you deployed:
```bash
terraform destroy
```

---

## Outputs (what to expect)

From **`environments/*/outputs.tf`**:
- `alb_dns_name` (string) – ALB endpoint
- `db_endpoint` (string) – RDS hostname
- `autoscaling_group_name` (string) – ASG name


## Documentation
A step-by-step walkthrough can be found here: https://www.notion.so/Step-by-Step-Guide-Multi-Environment-WebApp-Infrastructure-with-Terraform-25d73770dae980dc8245f7047f137389?source=copy_link
