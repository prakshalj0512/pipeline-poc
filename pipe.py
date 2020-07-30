import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('CodeCommit Lambda Function at Work to S3! Now, onto CodeDeploy try')
    }
