# README

This Helm chart is used to deploy a Kubernetes application. The following documentation provides details on the configurable values and their default settings.

## Table of Contents

- [README](#readme)
  - [Table of Contents](#table-of-contents)
  - [Parameters](#parameters)
    - [Global Parameters](#global-parameters)
    - [Service Parameters](#service-parameters)
    - [Ingress Parameters](#ingress-parameters)
    - [Configuration Parameters](#configuration-parameters)
    - [Register Container Parameters](#register-container-parameters)
    - [Node Container Parameters](#node-container-parameters)
    - [Pod Parameters](#pod-parameters)
    - [Service Account Parameters](#service-account-parameters)
    - [VM Pod Scrape Parameters](#vm-pod-scrape-parameters)
  - [Example](#example)

## Parameters

### Global Parameters

| Parameter          | Description                          | Default |
|--------------------|--------------------------------------|---------|
| `nameOverride`     | Optionally override the name of the chart | `""`    |
| `fullnameOverride` | Optionally override the full name of the chart | `""`    |
| `replicaCount`     | Number of replicas to deploy         | `1`     |
| `labels`           | Additional labels to add to resources | `{}`    |
| `imagePullSecrets` | Secrets for pulling images from a private registry | `[]`    |

### Service Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `service.annotations`    | Annotations to add to the service    | `{}`          |
| `service.type`           | Type of service to create            | `ClusterIP`   |
| `service.ports`          | List of ports to expose from the service | `[]`          |

### Ingress Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `ingress.annotations`    | Annotations to add to the ingress    | `{}`          |
| `ingress.enabled`        | Enable or disable the ingress        | `false`       |
| `ingress.host`           | Hostname for the ingress             | `example.com` |

### Configuration Parameters

| Parameter                   | Description                          | Default       |
|-----------------------------|--------------------------------------|---------------|
| `configs.operator.yaml`     | Configuration file for the operator  | `# some configs via file` |

### Register Container Parameters

| Parameter                         | Description                          | Default       |
|-----------------------------------|--------------------------------------|---------------|
| `register.enabled`                | Enable or disable the register container | `true`       |
| `register.image.repository`       | Image registry for the register container | `<IMAGE_REGISTRY>` |
| `register.image.pullPolicy`       | Image pull policy for the register container | `Always`      |
| `register.image.tag`              | Image tag for the register container | `<IMAGE_TAG>` |
| `register.args`                   | Arguments to pass to the register container | `["--config=/app/config/operator.yaml", "register-operator-with-avs"]` |

### Node Container Parameters

| Parameter                         | Description                          | Default       |
|-----------------------------------|--------------------------------------|---------------|
| `node.volumeMounts`               | Volume mounts for the node container | `[]`          |
| `node.image.repository`           | Image registry for the node container | `<IMAGE_REGISTRY>` |
| `node.image.pullPolicy`           | Image pull policy for the node container | `Always`      |
| `node.image.tag`                  | Image tag for the node container     | `<IMAGE_TAG>` |
| `node.ports`                      | Ports to expose from the node container | `[]`          |
| `node.resources`                  | Resource limits and requests for the node container | `{}`          |
| `node.env`                        | Environment variables for the node container | `[]`          |
| `node.args`                       | Arguments to pass to the node container | `[]`          |
| `node.readinessProbe`             | Readiness probe for the node container | `{}`          |
| `node.livenessProbe`              | Liveness probe for the node container | `{}`          |

### Pod Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `nodeSelector`           | Node selector for the pod            | `{}`          |
| `tolerations`            | Tolerations for the pod              | `[]`          |
| `affinity`               | Affinity rules for the pod           | `{}`          |
| `podAnnotations`         | Annotations to add to the pod        | `{}`          |
| `podSecurityContext`     | Security context for the pod         | `{}`          |
| `securityContext`        | Security context for the container   | `{}`          |
| `volumes`                | Volumes for the pod                  | `[]`          |

### Service Account Parameters

| Parameter                    | Description                          | Default       |
|------------------------------|--------------------------------------|---------------|
| `serviceAccount.create`      | Specifies whether a service account should be created | `true`       |
| `serviceAccount.annotations` | Annotations to add to the service account | `{}`          |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `""`          |

### VM Pod Scrape Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `vmPodScrape.enabled`    | Enable or disable VM Pod Scraping    | `true`        |

## Example

To deploy the chart with custom values, create a `values.yaml` file:

```yaml
replicaCount: 2

service:
  type: LoadBalancer
  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: 8080

ingress:
  enabled: true
  host: myapp.example.com

register:
  image:
    repository: my-registry/my-register
    tag: latest

node:
  image:
    repository: my-registry/my-node
    tag: stable
  resources:
    limits:
      cpu: 2
      memory: 2Gi
    requests:
      cpu: 1
      memory: 1Gi
```

Then install the chart using the Helm CLI:

```sh
helm install my-release -f values.yaml .
```
