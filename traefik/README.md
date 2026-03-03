## PURPOSE
Presentation of the procedure for installation and configuration of an Traefik service providing an API gateway as endpoint of all http/https services exposed by the CYBNITY layers.

The [Traefik GitHub project](https://github.com/traefik/traefik-helm-chart/tree/master) is reused, allowing to initialize a basic reverse proxy module sufficient for the exposure of CYBNITY services.

# Traefik Proxy
Traefik solution is reused as reverse proxy.

The Helm chart to install is based on:
- Helm chart repo: https://traefik.github.io/charts or oci://ghcr.io/traefik/helm
- Helm chart version: 39.0.1 (free version provided on [GitHub project](https://github.com/traefik/traefik-helm-chart/tree/master))

__values.yaml__ file applicable with default Traefik Helm chart is used to define a HTTP reverse proxy and load balancer configuration.

Traefik shall be installed into the "traefik" namespace by default.

See [Traefik Proxy document](https://doc.traefik.io/traefik/setup/kubernetes/) for installation procedure to follow with use of __values.yaml__ prepared file.

See [Traefik documentation](https://doc.traefik.io/traefik/) for mode detail on configuration.

## Gateway API
The Ingress control relative to externally exposed application services (e.g. access-control-sso ingress component via Traefik) is implemented by Kubernetes Gateway API specification that is an official Kubernetes project focused on L4 and L7 routing (Ingress, Load Balancing and Service Mesh APIs).

See [SIGS documentation](https://gateway-api.sigs.k8s.io/) for more information about standard Kubernetes Gateway API.

### CRDs
Traefik provider compatible with Gateway API require CRDs pre-installed. They are provided by SIGS on [GitHub open source project](https://github.com/kubernetes-sigs/gateway-api) and are copied from the SIGS project [releases](https://github.com/kubernetes-sigs/gateway-api/releases) repository.

The embeddeding of CRDs is managed into the [crds folder](crds) via a copy of the SIG file allowing automatic creation of namespace.

The automatic installation of CRDs by Helm 3+ is ensured during the project installation, but none modification or deletion is ensured during eventual upgrade of the Helm project re-installation. Manual deletion from K8S cluster is required if new CRDs version shall be installed in place of previous existing version. See [Helm documentation about CRDs](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/).

## Installation of Traefik Proxy
Deployment in an environment is performed via the Helm command line:
```console
helm repo add traefik https://traefik.github.io/charts
helm repo update
# Create of namespace traefik
kubectl create namespace traefik

# Install Traefik Proxy into the cluster and all Traefik components into the traefik dedicated namespace
helm install traefik traefik/traefik --namespace traefik --values values.yaml
```

## Traefik Proxy configuration change
When any configuration is changed on the traefik project values.xml file, apply them via command:
```console
helm upgrade traefik traefik/traefik --namespace traefik --reuse-values -f ./traefik/values.yaml
```

### Default access to dashboard
The Traefik Proxy access to dashboard is defined by default as "opened" on web port callable from [web browser url](http://localhost/dashboard/).

This default dashboard (read-only ability on cluster routes) visibility shall be unactivated on production environment via specific __values.yalm__ configuration file attributes. 

## Gateway API for routing management to CYBNITY services
To use the Gateway API, installation of Gateway CRDs in the cluster is required.

Else, CRDs installation can be performed via command:

```console
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.1/standard-install.yaml

# Install Traefik Resource Definitions:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.6/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

# Install RBAC for Traefik:
kubectl apply -f https://raw.githubusercontent.com/traefik/traefik/v3.6/docs/content/reference/dynamic-configuration/kubernetes-crd-rbac.yml
```

The configuration enable the usage of the Kubernetes Gateway API specification to support the automated configuration of Ingress in Kubernetes.

Gateway API ensure automatic creation of default GatewayClass resource (named __traefik-apis-gw__) as default provider of initial Gateway (named __traefik-apis-gateway__) which can be refernced by CYBNITY Platform sub-projects (e.g since [ui-apis-gateway](../cybnity-platform/charts/ui-apis-gateway/) sub-project).

For more information, see Gateway API documentation at https://gateway-api.sigs.k8s.io/.
    
### HTTPRoute configurations
The __ui-apis-gateway__ Helm project includes the managed configuration resources (over its __values.yaml__ file and templates) to customize the CYBNITY application routes that Traefik shall manage.

#
[Back To Home](../README.md)
