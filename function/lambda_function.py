import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the 08/31 function. Thanks for visiting.')
    }