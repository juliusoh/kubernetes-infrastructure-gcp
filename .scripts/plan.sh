#!/bin/bash
###########################################
# Set the terraform variables
###########################################

source .scripts/variables.sh

###########################################
# Test for the presence of the GCP_CI_SERVICE_KEY variable
# The GCP_CI_SERVICE_KEY varialbe is set by the gitlab pipeline
# Therefore, if this variable is present then this must be running in the pipeline
# If the GCP_CI_SERVICE_KEY is NOT present then this must be running locally
# and the service-key.json must exist in the .secrets directory
# If you do not have this service-key.json you can create on on the IAM Console
###########################################

if test "$GCP_CI_SERVICE_KEY"
then
  echo $GCP_CI_SERVICE_KEY
  mkdir -p .secrets
  ls -a 
  cp $GCP_CI_SERVICE_KEY .secrets/service-key.json
fi

export GOOGLE_APPLICATION_CREDENTIALS=.secrets/service-key.json

###########################################
# Run terraform
###########################################

terraform init \
  -backend-config="bucket=$TF_VAR_state_bucket" \
  -backend-config="prefix=$TF_VAR_gcp_cluster_location/project"
terraform plan -out tfapply