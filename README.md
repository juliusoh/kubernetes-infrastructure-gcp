## Project Infrastructure


### To run Terraform locally

To run Terraform locally a service account must exist with the appropriate permissions. If you do not have a service account key one can be created from the IAM console and downloaded to you .secrets directory in this repo. For simplicity rename the service key file to `service-key.json`

```bash
npm run plan
npm run apply

# OR

bash .scripts/plan.sh
bash .scripts/apply.sh
```

### To run the initial setup of the kubernetes cluster locally

This will create an NGINX ingress and install cert-manager

```bash
npm run k8s

# OR

bash .scripts/k8s.sh
```

## Optional - Install GitLab Runner

If a Gitlab runner is needed run the following code

```bash
helm repo add gitlab https://charts.gitlab.io
kubectl apply -f gitlab-runner/namespace.yaml
helm install --namespace gitlab-runner gitlab-runner -f gitlab-runner/values.yaml gitlab/gitlab-runner
```