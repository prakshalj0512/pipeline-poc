import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the dev function. Thanks for visiting. Have a nice day!')
    }