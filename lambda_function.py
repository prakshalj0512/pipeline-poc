import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('CodeCommit Lambda Function at Work to S3! Now, onto CodeDeploy try')
    }


# aws lambda update-function-code --function-name pjain-func --s3-bucket pjain-git-s3 --s3-key pipe.py --dry-run