#!/bin/bash

# Configuration
AWS_ACCOUNT_ID="071735315475"
INSTANCE_ID="8edb573d-9b54-4780-9ef9-3951cc8dc9fb"
CONTACT_FLOW_NAME="GreetCallerFlow"
CONTACT_FLOW_FILE="contact-flows/greetCallerFlow.json"

# Verify file exists
echo "Checking contact flow file..."
if [ ! -f "$CONTACT_FLOW_FILE" ]; then
    echo "Error: Contact flow file not found at $CONTACT_FLOW_FILE"
    echo "Current directory: $(pwd)"
    ls -la contact-flows/
    exit 1
fi

# Verify AWS connectivity
echo "Testing AWS credentials..."
aws sts get-caller-identity || {
    echo "AWS credentials not configured properly"
    exit 1
}

# Import contact flow with error handling
echo "Importing contact flow..."
aws connect import-contact-flow \
    --instance-id "$INSTANCE_ID" \
    --name "$CONTACT_FLOW_NAME" \
    --content "file://$CONTACT_FLOW_FILE" \
    --type CONTACT_FLOW || {
    echo "Failed to import contact flow"
    exit 1
}

echo "Contact flow imported successfully"