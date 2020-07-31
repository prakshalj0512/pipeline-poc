import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the prod function. Thanks for visiting.')
    }


# aws lambda update-function-code --function-name pjain-func --s3-bucket pjain-git-s3 --s3-key pipe.py --dry-run