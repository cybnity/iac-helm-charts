## PURPOSE
Presentation of the procedure for installation and configuration of an Traefik service providing an API gateway as endpoint of all http/https services exposed by the UI layer.

The [Traefik GitHub project](https://github.com/traefik/traefik-helm-chart/tree/master) is reused, allowing to initialize a basic reverse proxy module sufficient for the exposure of exposed services for endpoints control:
- Access-control-sso system over HTTP/HTTPS (Keycloak server)
- Web-reactive-frontend application system over HTTP/HTTPS (Javascript/HTML5 web application)
- Reactive-messaging-gateway system over SockJS/HTTPS (Vert.x messaging server)

# Traefik
Traefik solution is reused as reverse proxy.

Helm chart is used to define a reverse proxy with Traefik.

See [Traefik documentation](https://doc.traefik.io/traefik/) for mode detail on its configuration.

## Installation of ui-apis-gateway-system
The reverse proxy and its load balancing as cluster's entrypoint is implemented via Traefik.

Deployment in an environment is performed via the Helm command line:

```console
helm install ui-apis-gateway-system -f ./ui-apis-gateway/values.yaml ./ui-apis-gateway/
```

## External access to proxy's pods

## Routing
The __ui-apis-gateway__ helm project configuration file (values.yaml) help to customize the original Traefik Helm chart, including:
- external exposure of unified entrypoint (proxy on port 80) > internal routing configuration (e.g port mapping) > dedicated services (e.g access-control-sso-system, reactive-backend-system, web-reactive-frontend-system)
