#!/bin/bash
###########################################
# Update helm
###########################################

helm repo add jetstack https://charts.jetstack.io
helm repo update

###########################################
# Install NGINX
###########################################

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --wait

###########################################
# Install Cert Manager
###########################################

helm upgrade --install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true \
  --wait

###########################################
# Install cert manager issuer
###########################################

helm upgrade --install cert-manager-issuer k8s/cert-manager-issuer \
  --namespace cert-manager \
  --wait