echo $S3_BUCKET
echo $LAMBDA_FUNCTION_NAME
# CURRENT_LAMBDA_VERSION=$(aws lambda get-alias --function-name $LAMBDA_FUNCTION_NAME --name $LAMBDA_FUNCTION_ALIAS | jq -r '.FunctionVersion')

zip -rj lambda_function.zip function/*

# aws lambda update-function-code --function-name $LAMBDA_FUNCTION_NAME --zip-file fileb://lambda_function.zip --publish > response.json
# aws lambda get-version alias functinon_name
# TARGET_VERSION=$(cat response.json | jq -r '.Version')
UNIQUE_ID=$(openssl rand -base64 12)
# mv lambda_function.zip ${LAMBDA_FUNCTION_NAME}_${UNIQUE_ID}.zip

cat > template.yaml << EOM
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Resources:
  LambdaFunction:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: ${LAMBDA_FUNCTION_NAME}
      Handler: lambda_function.lambda_handler
      Runtime: python3.7
      CodeUri: s3://${S3_BUCKET}/${LAMBDA_FUNCTION_NAME}.zip
      AutoPublishAlias: default
      Timeout: 30
      DeploymentPreference:
        Enabled: True
        Type: AllAtOnce
EOM

cat template.yaml