module "s3_lambda_copy" {
  source = "./modules/s3_lambda_copy"

  MySourceBucket21      = "My-SourceBucket-21"
  MyDestinationBucket21 = "My-DestinationBucket-21"

}