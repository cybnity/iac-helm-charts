# Cert-Manager
[Cert Manager](https://cert-manager.io/docs/) is a toolset that manages certificates and supports Let’s Encrypt.

Install the Cert Manager addon into Kubernetes from [ArtifactHUB Helm chart](https://artifacthub.io/packages/helm/cert-manager/cert-manager) to automate the management and issurance of TLS certificates from various issuing sources (e.g Let's Encrypt for development environment, Vault for production environment).

The Helm chart project is managed as reference chart on [GitHub project](https://github.com/cert-manager/cert-manager).

## CRD
Installation of CustomResourceDefinition resources is recommended by kubectl (see [cert-manager tutorial](https://cert-manager.io/docs/tutorials/getting-started-with-cert-manager-on-google-kubernetes-engine-using-lets-encrypt-for-ingress-ssl/) for help) and not from Helm chart avoiding an automatic CRDs instances deletion when CYBNITY Platform environment is upgraded or deleted from Helm CLI:

```shell
# kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.11.1/cert-manager.crds.yaml
# Install cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.17.2/cert-manager.yaml

# Check that deployment and resources have been installed
kubectl -n cert-manager get all

```

## HELM CHART
Deployment of charts from this folder with redefined default values:

```shell
## Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

### Install by sub-chart
By default, the sub-chart dedicated to auto-installation of cert-manager is defined.

### Install from command-line
An alternative installation can be made over command lines execution.

## Install the cert-manager chart release (named cert-manager-uia) with custom values.yaml deployed into the node of UI layer (labelized as user-interfaces-area)
helm install cert-manager --namespace cert-manager --create-namespace --version v1.11.1 -f ./cert-manager/values.yaml jetstack/cert-manager

## Check running pods
kubectl get pods --namespace cert-manager
```

### Clean previous/old ValidatingWebhookConfigurations
When existing ingress-nginx namespace is removed, this does not remove the validating webhook configurations.

```shell
## Check is there any old webhook configuration on cluster instance
kubectl get validatingwebhookconfigurations

### Delete each one
kubectl delete validatingwebhookconfigurations <NAME>

```

### Test creation of certificate resource

```shell
kubectl apply -f ./cert-manager/test-resources.yaml
```

## Cert-manager Command Line Tool (cmctl)
[Install](https://cert-manager.io/docs/reference/cmctl/#installation) the command line tool of cert-manager allowing to verify the good installation of cert-manager artifacts.

# Kubernetes NGINX Ingress Controller
This Ingress controller is developed as a reverse proxy and load balancer for Kubernetes via [GitHub](https://github.com/kubernetes/ingress-nginx).

Maintained by the Kubernetes community, see [documentation](https://kubernetes.github.io/ingress-nginx/) for more details.
