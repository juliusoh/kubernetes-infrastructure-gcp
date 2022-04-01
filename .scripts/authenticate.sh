#!/bin/bash
###########################################
# Set variables TF variables
###########################################

. .scripts/variables.sh

###########################################
# Test for the presence of the GCP_CI_SERVICE_KEY variable
# The GCP_CI_SERVICE_KEY varialbe is set by the gitlab pipeline
# Therefore, if this variable is present then this must be running in the pipeline
# If the GCP_CI_SERVICE_KEY is NOT present then this must be running locally and use local credentials
###########################################

if test "$GCP_CI_SERVICE_KEY"
then
  gcloud auth activate-service-account --key-file $GCP_CI_SERVICE_KEY
else
  gcloud init
fi

###########################################
# Connect to cluster
###########################################

export KUBECONFIG=kube.conf && gcloud container clusters get-credentials $TF_VAR_gcp_cluster_name --zone $TF_VAR_gcp_cluster_location --project $TF_VAR_gcp_project

kubectl get pods