echo $S3_BUCKET
echo $CODE_DEPLOY_DEPLOYMENT_GROUP
echo $LAMBDA_FUNCTION_NAME
echo $CODE_DEPLOY_APP_NAME
echo $LAMBDA_FUNCTION_ALIAS

CURRENT_LAMBDA_VERSION=$(aws lambda get-alias --function-name $LAMBDA_FUNCTION_NAME --name $LAMBDA_FUNCTION_ALIAS | jq -r '.FunctionVersion')

zip function.zip function/*

aws lambda update-function-code --function-name $LAMBDA_FUNCTION_NAME --zip-file fileb://function.zip --publish > response.json
TARGET_VERSION=$(cat response.json | jq -r '.Version')

cat > AppSpec.yaml << EOM
version: 0
Resources:
- myLambdaFunction:
    Type: AWS::Lambda::Function
    Properties:
      Name: $LAMBDA_FUNCTION_NAME
      Alias: $LAMBDA_FUNCTION_ALIAS
      CurrentVersion: $CURRENT_LAMBDA_VERSION
      TargetVersion: $TARGET_VERSION
EOM
