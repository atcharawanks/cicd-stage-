#!/bin/bash
     ENVIRONMENT=$1
     aws cloudformation deploy --template-file templates/master.yaml --stack-name ${ENVIRONMENT}-master-stack --region us-east-1 \
       --parameter-overrides Environment=${ENVIRONMENT} VpcId=vpc-12345678 \
       PublicSubnetIds=subnet-12345678,subnet-87654321 \
       PrivateSubnetIds=subnet-abcdef12,subnet-21fedcba \
       GitHubOwner=your-org GitHubRepo=my-app GitHubBranch=main \
       GitHubOAuthToken=$GITHUB_TOKEN DBPassword=$DB_PASSWORD \
       --capabilities CAPABILITY_NAMED_IAM