#!/bin/bash

# Configuration
STACK_NAME="amazon-connect-cicd-stack"
TEMPLATE_FILE="infrastructure/template.yaml"

# Verify template exists
echo "Checking template file..."
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: Template file not found at $TEMPLATE_FILE"
    echo "Current directory: $(pwd)"
    ls -la infrastructure/
    exit 1
fi

# Verify AWS connectivity
echo "Testing AWS credentials..."
aws sts get-caller-identity || {
    echo "AWS credentials not configured properly"
    exit 1
}

# Deploy CloudFormation stack
echo "Deploying CloudFormation stack..."
aws cloudformation deploy \
    --template-file "$TEMPLATE_FILE" \
    --stack-name "$STACK_NAME" \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --no-fail-on-empty-changeset || {
    echo "Failed to deploy stack"
    aws cloudformation describe-stack-events \
        --stack-name "$STACK_NAME" \
        --query 'StackEvents[?contains(ResourceStatus,`FAILED`)]' \
        --output table
    exit 1
}

echo "Stack deployed successfully"