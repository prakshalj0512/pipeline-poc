echo $S3_BUCKET
echo $LAMBDA_FUNCTION_NAME
echo $LAMBDA_FUNCTION_ALIAS

# CURRENT_LAMBDA_VERSION=$(aws lambda get-alias --function-name $LAMBDA_FUNCTION_NAME --name $LAMBDA_FUNCTION_ALIAS | jq -r '.FunctionVersion')

zip -rj lambda_function.zip function/*

# aws lambda update-function-code --function-name $LAMBDA_FUNCTION_NAME --zip-file fileb://lambda_function.zip --publish > response.json
# TARGET_VERSION=$(cat response.json | jq -r '.Version')
mv lambda_function.zip lambda_function_${LAMBDA_FUNCTION_ALIAS}_${TARGET_VERSION}.zip

# cat > AppSpec.yml << EOM
# version: 0
# Resources:
# - myLambdaFunction:
#     Type: AWS::Lambda::Function
#     Properties:
#       Name: $LAMBDA_FUNCTION_NAME
#       Alias: $LAMBDA_FUNCTION_ALIAS
#       CurrentVersion: $CURRENT_LAMBDA_VERSION
#       TargetVersion: $TARGET_VERSION
# EOM

cat > template.yaml << EOM
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: My Lambda function
Resources:
  LambdaFunction:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: ${LAMBDA_FUNCTION_NAME}
      Description: My Lambda function
      Handler: lambda_function.lambda_handler
      Runtime: python3.7
      CodeUri: s3://${S3_BUCKET}/lambda_function_${LAMBDA_FUNCTION_ALIAS}_${TARGET_VERSION}.zip
      AutoPublishAlias: live
      Timeout: 30
      DeploymentPreference:
        Enabled: True
        Type: AllAtOnce
EOM

cat template.yaml