import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the PROD2012020new function. Thanks for visiting.')
    }