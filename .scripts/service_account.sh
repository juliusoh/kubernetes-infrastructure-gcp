#!/bin/bash
###########################################
# Set variables Service Account
###########################################

source .scripts/variables.sh

###########################################
# Create Service Account
###########################################

# Create Service Account
gcloud iam service-accounts create dns01-solver --display-name "dns01-solver"

# Add permisisons
gcloud projects add-iam-policy-binding $TF_VAR_gcp_project \
   --member serviceAccount:dns01-solver@$TF_VAR_gcp_project.iam.gserviceaccount.com \
   --role roles/dns.admin

# Create key
gcloud iam service-accounts keys create .secrets/key.json \
   --iam-account dns01-solver@$TF_VAR_gcp_project.iam.gserviceaccount.com

###########################################
# Create Service Account
###########################################

# kubectl create secret generic clouddns-dns01-solver-svc-acct --from-file=.secrets/key.json -n cert-manager
