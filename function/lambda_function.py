import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the dev asdfasd function renewed v88. a Thanks for visiting. Have a nice day! Time to go PLEASE CHANGE!')
    }