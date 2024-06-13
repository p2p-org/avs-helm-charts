# README

This Helm chart is used to deploy a Kubernetes application. The following documentation provides details on the configurable values and their default settings.

## Table of Contents

- [README](#readme)
  - [Table of Contents](#table-of-contents)
  - [Parameters](#parameters)
    - [Global Parameters](#global-parameters)
    - [PVC Parameters](#pvc-parameters)
    - [Service Parameters](#service-parameters)
    - [Ingress Parameters](#ingress-parameters)
    - [Configuration Parameters](#configuration-parameters)
    - [Node Container Parameters](#node-container-parameters)
    - [Pod Parameters](#pod-parameters)
    - [Service Account Parameters](#service-account-parameters)
    - [VM Pod Scrape Parameters](#vm-pod-scrape-parameters)
  - [Example](#example)
  - [License](#license)

## Parameters

### Global Parameters

| Parameter          | Description                          | Default |
|--------------------|--------------------------------------|---------|
| `nameOverride`     | Optionally override the name of the chart | `""`    |
| `fullnameOverride` | Optionally override the full name of the chart | `""`    |
| `replicaCount`     | Number of replicas to deploy         | `1`     |
| `labels`           | Additional labels to add to resources | `{}`    |
| `imagePullSecrets` | Secrets for pulling images from a private registry | `[]`    |

### PVC Parameters

| Parameter                | Description                          | Default |
|--------------------------|--------------------------------------|---------|
| `pvc.size`               | Size of the persistent volume claim  | `10Gi`  |
| `pvc.storageClassName`   | Storage class name for the PVC       | `""`    |
| `pvc.labels`             | Labels to add to the PVC             | `{}`    |
| `pvc.annotations`        | Annotations to add to the PVC        | `{}`    |

### Service Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `service.annotations`    | Annotations to add to the service    | `{}` |
| `service.type`           | Type of service to create            | `LoadBalancer`|
| `service.ports`          | List of ports to expose from the service | `[{ name: node-api, port: 8080, protocol: TCP, targetPort: 8080 }, { name: metrics, port: 9090, protocol: TCP, targetPort: 9090 }, { name: task-server, port: 9010, protocol: TCP, targetPort: 9010 }]` |

### Ingress Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `ingress.annotations`    | Annotations to add to the ingress    | `{}`          |
| `ingress.enabled`        | Enable or disable the ingress        | `false`       |
| `ingress.host`           | Hostname for the ingress             | `example.com` |

### Configuration Parameters

| Parameter                   | Description                          | Default       |
|-----------------------------|--------------------------------------|---------------|
| `configs.operator.yaml`     | Configuration file for the operator  | ```yaml environment: production eth_rpc_url: https://lb.drpc.org/ogrpc?network=ethereum avs_service_manager_address: 0xdE93E0dA148e1919bb7f33cd8847F96e45791210 node_eigen_api_server_host_and_port: 0.0.0.0:8080 eigen_metrics_ip_port_address: 0.0.0.0:9090 node_task_server_host_and_port: 0.0.0.0:9010 aggregator_server_ip_port_address: holesky.task.aethos.network:50051``` |

### Node Container Parameters

| Parameter                         | Description                          | Default       |
|-----------------------------------|--------------------------------------|---------------|
| `node.volumeMounts`               | Volume mounts for the node container | `[{ name: ecdsa-key, mountPath: /app/operator_keys/ecdsa_key.json, subPath: ecdsa_key.json, readOnly: true }, { name: aethos, mountPath: /app/data/ }]` |
| `node.image.repository`           | Image registry for the node container | `ghcr.io/aethosnetwork/operator` |
| `node.image.pullPolicy`           | Image pull policy for the node container | `Always`      |
| `node.image.tag`                  | Image tag for the node container     | `latest`      |
| `node.ports`                      | Ports to expose from the node container | `[{ name: node-api, containerPort: 8080, protocol: TCP }, { name: metrics, containerPort: 9090, protocol: TCP }, { name: task-server, containerPort: 9010, protocol: TCP }]` |
| `node.resources`                  | Resource limits and requests for the node container | `{ limits: { cpu: 4, memory: 16Gi }, requests: { cpu: 2, memory: 8Gi } }` |
| `node.env`                        | Environment variables for the node container | `[{ name: AETHOS_SIGNING_PRIVATE_KEY_STORE_PATH, value: "/app/operator_keys/ecdsa_key.json" }, { name: OPERATOR_ID, value: $YOU_OPERATOR_ID }, { name: AETHOS_SIGNING_PRIVATE_KEY_PASSWORD, valueFrom: { secretKeyRef: { name: YOURSECREWITHWALLET, key: ecdsa-private-key-password } } }, { name: NODE_TASK_SERVER_HOST_AND_PORT_TO_BROADCAST, value: 127.0.0.1:9010 }, { name: ETH_RPC_URL, value: https://lb.drpc.org/ogrpc?network=holesky }]` |
| `node.args`                       | Arguments to pass to the node container | `["start", "--config=/app/config/operator.yaml"]` |
| `node.readinessProbe`             | Readiness probe for the node container | `{ httpGet: { path: /metrics, port: 9090 }, initialDelaySeconds: 30, periodSeconds: 10, timeoutSeconds: 3, failureThreshold: 3, successThreshold: 1 }` |

### Pod Parameters

| Parameter                | Description                          | Default       |
|--------------------------|--------------------------------------|---------------|
| `nodeSelector`           | Node selector for the pod            | `{}`          |
| `tolerations`            | Tolerations for the pod              | `[]`          |
| `affinity`               | Affinity rules for the pod           | `{}`          |
| `podAnnotations`         | Annotations to add to the pod        | `{}`          |
| `podSecurityContext`     | Security context for the pod         | `{}`          |
| `securityContext`        | Security context for the container   | `{}`          |
| `volumes`                | Volumes for the pod                  | `[{ name: ecdsa-key, secret: { secretName: YOURSECREWITHWALLET, items: [{ key: ecdsa-private-key, path: ecdsa_key.json }] } }, { name: aethos, persistentVolumeClaim: { claimName: aethos } }]` |

### Service Account Parameters

| Parameter                    | Description                          | Default       |
|------------------------------|--------------------------------------|---------------|
| `serviceAccount.create`      | Specifies whether a service account should be created | `false`       |
| `serviceAccount.annotations` | Annotations to add to the service account | `{}`          |
| `serviceAccount.name`        | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | `aethos`      |

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
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
helm upgrade -i  aethos-release  p2p-avs/aethos -f values.holesky.yaml
```

## License

This Helm chart is licensed under the MIT License. See the LICENSE file for more information.
