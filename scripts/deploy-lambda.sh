#!/bin/bash
aws cloudformation deploy \
    --template-file ../infrastructure/template.yaml \
    --stack-name amazon-connect-cicd-stack \
    --capabilities CAPABILITY_NAMED_IAM