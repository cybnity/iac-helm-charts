## PURPOSE
Presentation of the procedure for installation and configuration of an Traefik service providing an API gateway as endpoint of all http/https services exposed by the UI layer.

The [Traefik GitHub project](https://github.com/traefik/traefik-helm-chart/tree/master) is reused, allowing to initialize a basic reverse proxy module sufficient for the exposure of exposed services for endpoints control:
- Access-control-sso system over HTTP/HTTPS (Keycloak server)
- Web-reactive-frontend application system over HTTP/HTTPS (Javascript/HTML5 web application)
- Reactive-messaging-gateway system over SockJS/HTTPS (Vert.x messaging server)

# Traefik
Traefik solution is reused as reverse proxy.

Helm chart is used to define a HTTP reverse proxy and load balancer with Traefik.

See [Traefik documentation](https://doc.traefik.io/traefik/) for mode detail on its configuration.

## Gateway API
The Ingress control relative to externally exposed application services (e.g. access-control-sso ingress component via Traefik) is implemented by Kubernetes Gateway API specification that is an official Kubernetes project focused on L4 and L7 routing (Ingress, Load Balancing and Service Mesh APIs).

See [SIGS documentation](https://gateway-api.sigs.k8s.io/) for more information about standard Kubernetes Gateway API.

### CRDs
Traefik provider compatible with Gateway API require CRDs pre-installed. They are provided by SIGS on [GitHub open source project](https://github.com/kubernetes-sigs/gateway-api) and are copied from the SIGS project [releases](https://github.com/kubernetes-sigs/gateway-api/releases) repository.

The embeddeding of CRDs is managed into the [crds folder](crds) via a copy of the SIG file allowing automatic deployment by the CYBNITY project (avoiding to pre-install into cluster the CRDs by operator before to install CYBNITY Platform via Helm).

The automatic installation of CRDs by Helm 3+ is ensured during the project installation, but none modification or deletion is ensured during eventual upgrade of the __ui-apis-gateway__ project re-install. Manual deletion from K8S cluster is required if new CRDs version shall be installed in place of previous existing version. See [Helm documentation about CRDs](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/).

## Installation of ui-apis-gateway-system
Deployment in an environment is performed via the Helm command line:

```console
helm install ui-apis-gateway-system -f ./ui-apis-gateway/values.yaml ./ui-apis-gateway/
```

## External access to proxy's pods

## Routing
The __ui-apis-gateway__ helm project configuration file (values.yaml) help to customize the original Traefik Helm chart, including:
- external exposure of unified entrypoint (proxy on port 80) > internal routing configuration (e.g port mapping) > dedicated services (e.g access-control-sso-system, reactive-backend-system, web-reactive-frontend-system)
