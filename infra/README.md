# My Infrastructure as Code (IaC)

This repository manages the infrastructure for a complete cloud-native application stack using AWS CloudFormation, structured with modular templates, deployment scripts, and documentation.

---

## 📁 Folder Structure

```plaintext
my-infra/
├── templates/               # CloudFormation templates
│   ├── ecr.yaml             # Defines the Amazon ECR repository for container images
│   ├── ecs.yaml             # Provisions ECS Cluster, Fargate Service, and Application Load Balancer
│   ├── rds.yaml             # Sets up an Amazon RDS MySQL database
│   ├── parameter-store.yaml # Creates entries in SSM Parameter Store for configuration
│   ├── cicd.yaml            # Configures CodePipeline and CodeBuild for CI/CD
│   ├── master.yaml          # Root stack that references and links all the above templates
├── scripts/                 # Deployment and helper scripts
│   ├── deploy.sh            # Shell script to deploy stacks using AWS CLI or CloudFormation
├── docs/                    # Documentation and visuals
│   ├── DeploymentGuide.md   # Step-by-step deployment instructions
│   ├── architecture.png     # System architecture diagram (created with Draw.io)
├── README.md                # Repository overview and usage
