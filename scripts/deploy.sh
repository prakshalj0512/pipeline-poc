echo $S3_BUCKET
echo $LAMBDA_FUNCTION_NAME
echo $LAMBDA_DEPLOYMENT_PREFERENCE
echo $BRANCH

CURRENT_LAMBDA_FUNCTION_VERSION=$(aws lambda list-versions-by-function --function-name $LAMBDA_FUNCTION_NAME --query "Versions[-1].[Version]" | grep -o -E '[0-9]+')
((TARGET_LAMBDA_VERSION=CURRENT_LAMBDA_FUNCTION_VERSION++))
TARGET_LAMBDA_FUNCTION_CODE="${LAMBDA_FUNCTION_NAME}_v${TARGET_LAMBDA_VERSION}.zip"
zip -rj ${TARGET_LAMBDA_FUNCTION_CODE} function/*
aws s3 cp ${TARGET_LAMBDA_FUNCTION_CODE} s3://${S3_BUCKET}/${BRANCH}

cat > template.yaml << EOM
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Resources:
  LambdaFunction:
    Type: AWS::Serverless::Function
    Properties:
      FunctionName: ${LAMBDA_FUNCTION_NAME}-${BRANCH}
      Handler: lambda_function.lambda_handler
      Runtime: python3.7
      CodeUri: s3://${S3_BUCKET}/${BRANCH}/${TARGET_LAMBDA_FUNCTION_CODE}
      AutoPublishAlias: default
      Timeout: 30
      DeploymentPreference:
        Enabled: True
        Type: ${LAMBDA_DEPLOYMENT_PREFERENCE}
EOM

cat template.yaml