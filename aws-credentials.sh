ASSUME_ROLE=""
aws_credentials=$(aws sts assume-role --role-arn "${ASSUME_ROLE}" --role-session-name "RoleSession" --output json)
export AWS_ACCESS_KEY_ID=$(echo "$aws_credentials"|jq '.Credentials.AccessKeyId'|tr -d '"')
export AWS_SECRET_ACCESS_KEY=$(echo "$aws_credentials"|jq '.Credentials.SecretAccessKey'|tr -d '"')
export AWS_SESSION_TOKEN=$(echo "$aws_credentials"|jq '.Credentials.SessionToken'|tr -d '"')