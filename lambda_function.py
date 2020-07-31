import json

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps('This is the qa function. Thanks for visiting.')
    }


# aws lambda update-function-code --function-name pjain-func --s3-bucket pjain-git-s3 --s3-key pipe.py --dry-run

# aws deploy create-deployment --application-name pjain-app --deployment-group-name pjain-deploy --revision String 


# {
#             "revisionType": "String",
#             "string": {
#               "content": "string",
#               "sha256": "string"
#             }
#           }