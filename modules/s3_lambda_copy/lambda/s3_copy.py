import boto3
import os
import logging

# boto3: AWS SDK for Python. Lets you interact with AWS services like S3.
# os: Used to get environment variables like the bucket names.
# logging: Helps us print messages to CloudWatch Logs.

#  Create an S3 client
# This creates a connection to the S3 service.
# You use this to list and copy files.
s3 = boto3.client('s3')
logger = logging.getLogger()
logger.setLevel(logging.INFO)

#This sets the logging level to INFO. This means you'll see print-style messages in 
# CloudWatch when the Lambda runs.



#  Main function: lambda_handler
def lambda_handler(event, context):
# This is the entry point AWS Lambda looks for when it runs your code.
# event: Data passed to the Lambda when triggered (not used here).
# context: Info about the runtime environment (not used here).
   source_bucket = os.environ['SOURCE_BUCKET']
   destination_bucket = os.environ['DESTINATION_BUCKET']
#  Read bucket names from environment
# These lines pull in the bucket names from environment variables. You passed these in using Terraform earlier.
#

#  Log start of process
   logger.info(f"Starting file copy from '{source_bucket}' to '{destination_bucket}'")

   try:
    #  : List all files in source bucket
     response = s3.list_objects_v2(Bucket=source_bucket)
    #  Handle the “empty bucket” case
     if 'Contents' not in response:
        logger.info("No files found in source bucket.")
# If there are no files, this avoids errors and logs a helpful message
        return {"status": "No files to copy"}

# : Loop through all files and copy them
     for obj in response['Contents']:
        key = obj['Key']
        logger.info(f"Copying file: {key}")
        
# Gets the name of each file in the source bucket.
# Logs which file it's working on.
        copy_source = {'Bucket': source_bucket, 'Key': key}
        
# Copies that file to the destination bucket using s3.copy_object().
        s3.copy_object(CopySource=copy_source,
                        Bucket=destination_bucket,
                        Key=key
                        )
        logger.info("File copy completed.")
        return {"status": "Success", "files": [obj['Key'] for obj in response['Contents']]}
     
    #  Handle errors (if anything fails)
   except Exception as e:
    logger.error(f"Error occurred during file copy: {e}")
    raise
   




#What does lamdba do : 
# Reads environment variables for source/destination bucket names
# Lists files in the source bucket
# Copies each file to the destination bucket
# Logs every step so you can troubleshoot if something goes wrong   