echo $S3_BUCKET
echo $CODE_DEPLOY_DEPLOYMENT_GROUP
echo $LAMBDA_FUNCTION_NAME
echo $CODE_DEPLOY_APP_NAME

aws lambda list-functions
aws lambda get-alias --function-name $LAMBDA_FUNCTION_NAME --name dev