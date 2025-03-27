## PURPOSE
Presentation of templates directory where Kubernetes resources are defined.

Each defined file in this area is representing a Kubernetes resource (e.g deployment.yaml, service.yaml) with placeholders that get filled dynamically with values from values.yaml or passed at deployment time.

Example files:
- __deployment.yaml__: defines how the application will be deployed (e.g number of replicas, image...)
- __service.yaml__: describes how the application will be exposed withing the cluster (e.g ClusterIP or LoadBalancer service type)
- __ingress.yaml__: configures the ingress rules to expose the application to external traffic
- __configmap.yaml__: used to store non-sensitive configuration data that the application needs
- __secret.yaml__: manages sensitive data such as passwords and API keys
- ___helpers.tpl__: template file used for reusable code snippets or helper functions

# namespace.yaml
This file is defining one or several namespace K8 resources as logical names dedicated to isolate objects (e.g configuration, CYBNITY components) specific to CYBNITY platform into the cluster where the application solution is deployed.

The template file read the namespaces defined into the __values.yaml__ file and create each one into the deployed cluster (via read of `.Values.namespaces`).

Example of each namespace configuration in __values.xml__:
```
  ### Namespace object configuration

  namespaces:
    - cybnity-system
    # To support cert-manager
    - cert-manager
```

#
[Back To Home](README.md)
