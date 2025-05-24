
#This tells Terraform you want to deploy your resources to AWS, specifically to the us-east-1 region (N. Virginia).
#Every AWS setup in Terraform needs a provider block.

provider "aws" {
region = "us-east-1"
}


#This creates an S3 bucket named whatever value you pass into the variable source_bucket_name. T
#Think of this as your “from” bucket — where your files live initially

resource "aws_s3_bucket" "source" {
bucket = var.MySourceBucket21
}

resource "aws_s3_bucket" "destination" {
bucket = var.MyDestinationBucket21
}


# Create an IAM Role for the Lambda:
#This role is like a user account for the Lambda. It tells AWS:
#"Hey, this role will be used by Lambda. Please allow Lambda to assume this role."
#This is required because Lambda needs permission to do anything — like read from S3 or write logs.

resource "aws_iam_role" "lambda_exec" {
name = "lambda_exec_role"

assume_role_policy = jsonencode({
Version = "2012-10-17"
Statement = [{
Action = "sts:AssumeRole"
Effect = "Allow"
Principal = {
Service = "lambda.amazonaws.com"
}
}]
})
}

#Define the permissions policy
# This gives the Lambda 3 permissions:
# Read and list files from the source bucket.
# Write (upload) files to the destination bucket.
# Write logs to CloudWatch Logs (so you can see what's happening).



resource "aws_iam_policy" "lambda_s3_policy" {
name = "lambda_s3_rw"

policy = jsonencode({
Version = "2012-10-17",
Statement = [
{
Action = ["s3:GetObject", "s3:ListBucket"],
Resource = [
"${aws_s3_bucket.source.arn}",
"${aws_s3_bucket.source.arn}/"
],
Effect = "Allow"
},
{
Action = ["s3:PutObject"],
Resource = ["${aws_s3_bucket.destination.arn}/"],
Effect = "Allow"
},
{
Action = ["logs:*"],
Resource = "",
Effect = "Allow"
}
]
})
}


# 🔗 Attach the policy to the role:
# This connects the policy you just created to the role. It tells AWS:
# “This role can do what’s allowed in this policy.”

resource "aws_iam_role_policy_attachment" "lambda_logs" {
role = aws_iam_role.lambda_exec.name
policy_arn = aws_iam_policy.lambda_s3_policy.arn
}


# 📦 Zip the Python code for Lambda:
#Lambda functions need to be uploaded as .zip files. This zips your Python file (s3_copy.py)
# and gets it ready for deployment




data "archive_file" "lambda_zip" {
type = "zip"
source_file = "${path.module}/lambda/s3_copy.py"
output_path = "${path.module}/lambda/s3_copy.zip"
}



# Deploy the Lambda function:
# This creates the Lambda function in AWS:
# filename: the zipped Python code.
# function_name: how you’ll identify this function in AWS.
# role: the IAM role Lambda will use.
# handler: points to the function in your Python file (lambda_handler).
# runtime: tells Lambda what language the code uses (Python 3.9 here).
# environment variables: these make your Python code reusable — you can access bucket names from inside the code.

resource "aws_lambda_function" "s3_copy" {
filename = data.archive_file.lambda_zip.output_path
function_name = "s3-copy-function"
role = aws_iam_role.lambda_exec.arn
handler = "s3_copy.lambda_handler"
source_code_hash = data.archive_file.lambda_zip.output_base64sha256
runtime = "python3.9"
timeout = 60
environment {
variables = {
SOURCE_BUCKET = var.MySourceBucket21
DESTINATION_BUCKET = var.MyDestinationBucket21
}
}
}

# Automatically invoke the Lambda after deployment:
# This uses a local exec provisioner — which is like Terraform saying:
# “After setting everything up, I’m going to run this shell command.”
# This command uses the AWS CLI to invoke the Lambda once. The result is saved to output.json and shown in your terminal.
# This is helpful for:
# Testing that everything works
# Automatically triggering the file-copying logic


resource "null_resource" "invoke_lambda_once" {
provisioner "local-exec" {
command = "aws lambda invoke --function-name ${aws_lambda_function.s3_copy.function_name} output.json && cat output.json"
}

depends_on = [aws_lambda_function.s3_copy]
}

