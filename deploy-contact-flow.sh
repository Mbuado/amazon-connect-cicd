#!/bin/bash
AWS_ACCOUNT_ID="071735315475"
INSTANCE_ID="8edb573d-9b54-4780-9ef9-3951cc8dc9fb"
CONTACT_FLOW_NAME="GreetCallerFlow"

# Import the contact flow
aws connect import-contact-flow \
    --instance-id $INSTANCE_ID \
    --name $CONTACT_FLOW_NAME \
    --content file://../contact-flows/greetCallerFlow.json \
    --type CONTACT_FLOW