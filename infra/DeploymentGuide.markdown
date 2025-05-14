# Deployment Guide

## Overview
This guide explains how to deploy and manage the application in UAT and Prod environments using AWS CloudFormation and CodePipeline.

## Prerequisites
- AWS CLI installed and configured
- GitHub repository access (`my-app` and `my-infra`)
- Environment variables: `GITHUB_TOKEN`, `DB_PASSWORD`

## Deploying Infrastructure
1. **Clone Infrastructure Repository**:
   ```bash
   git clone https://github.com/your-org/my-infra.git
   cd my-infra
   ```
2. **Deploy UAT**:
   ```bash
   ./deploy.sh uat
   ```
3. **Deploy Prod**:
   ```bash
   ./deploy.sh prod
   ```

## Deploying Application
1. **Clone Application Repository**:
   ```bash
   git clone https://github.com/your-org/my-app.git
   cd my-app
   ```
2. **Make Changes**:
   - Edit code in `src/`
   - Commit and push:
     ```bash
     git add .
     git commit -m "Update application"
     git push origin main
     ```
3. **Monitor Pipeline**:
   - Go to AWS CodePipeline console
   - Check pipeline status
   - Approve deployment to Prod in `ApproveProd` stage

## Rollback
- **Application Rollback**:
  - Revert code in GitHub and push to `main`
  - Pipeline will deploy previous version
- **Infrastructure Rollback**:
  - Use CloudFormation console to roll back stack:
    - Go to CloudFormation > Stacks > Select stack > Actions > Rollback
  - Or delete and redeploy:
    ```bash
    aws cloudformation delete-stack --stack-name uat-master-stack
    ./deploy.sh uat
    ```

## Troubleshooting
- Check CloudWatch Logs: `/ecs/uat-app` or `/ecs/prod-app`
- Check CodePipeline console for build errors
- Validate templates:
  ```bash
  aws cloudformation validate-template --template-body file://templates/master.yaml
  ```

## Contact
- Team: devops@your-org.com

ลำดับการ Deploy (อะไรก่อน-หลัง)
จากโค้ดที่ให้มา ลำดับการ deploy ควรเป็นดังนี้:
ECR: เพราะต้องมี repository สำหรับเก็บ Docker images ก่อน deploy แอป
Deploy ด้วย ecr.yaml หรือผ่าน master.yaml
RDS: เพราะแอปต้องเชื่อมต่อกับฐานข้อมูล
Deploy ด้วย rds.yaml หรือผ่าน master.yaml
Parameter Store: เพราะต้องเก็บ DB credentials ก่อนที่ ECS จะใช้
Deploy ด้วย parameter-store.yaml หรือผ่าน master.yaml
ECS: เพราะต้องมี cluster และ service สำหรับรันแอป
Deploy ด้วย ecs.yaml หรือผ่าน master.yaml
CI/CD Pipeline: เพราะต้องตั้งค่า pipeline เพื่อ deploy แอปอัตโนมัติ
Deploy ด้วย cicd.yaml หรือผ่าน master.yaml
Application Code: Push โค้ดไป GitHub เพื่อให้ pipeline ทำงาน

หมายเหตุ: การใช้ master.yaml ช่วยให้ deploy ทุกอย่างในครั้งเดียว โดยจัดการ dependencies ผ่าน nested stacks ดังนั้น ./deploy.sh uat หรือ ./deploy.sh prod จะ deploy ทุกอย่างในลำดับที่ถูกต้อง