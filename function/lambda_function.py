import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the PROD201 function. Thanks for visiting.')
    }