import json

def lambda_handler(event, context):
    # Access the 'Name' parameter from the event
    name = event.get('Details', {}).get('Parameters', {}).get('Name', 'Guest')
    
    # Return a response
    return {
        'statusCode': 200,
        'message': f'Hello, {name}! Welcome to Amazon Connect.'
    }