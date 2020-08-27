import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the PROD2012020 function. Thanks for visiting.')
    }