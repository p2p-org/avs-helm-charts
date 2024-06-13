# Helm Chart for ARPA Network Node

## Placeholders

The following placeholders need to be replaced with your actual values:

- `YOURSECREWITHWALLET_PLACEHOLDER`: Replace with the name of your Kubernetes secret containing the wallet.
- `YOUREXTERNALADDRESS_PLACEHOLDER`: Replace with your external address.
- `YOURADDRESS_PLACEHOLDER`: Replace with your specific address for log stream names.

## Overview

This Helm chart deploys an ARPA Network Node with the following features:
- Configurable replica count
- Customizable persistent volume claims
- LoadBalancer service with multiple ports
- Configurable node and cloudwatch settings
- Support for secret-based configuration

## Installation

To install the chart with the release name `arpa`:

```sh
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
helm upgrade -i arpa p2p-avs/arpa -f values.$NETWORK.yaml
```

## Configuration

The following table lists the configurable parameters of the ARPA Network Node chart and their default values.

| Parameter | Description | Default |
| --- | --- | --- |
| `nameOverride` | Override the name of the chart | `""` |
| `fullnameOverride` | Override the full name of the chart | `""` |
| `replicaCount` | Number of replicas for the deployment | `1` |
| `labels` | Additional labels for the deployment | `{}` |
| `pvc.size` | Persistent Volume Claim size | `10Gi` |
| `pvc.storageClassName` | Storage class for the PVC | `default` |
| `pvc.annotations` | Annotations for the PVC | `{}` |
| `pvc.labels` | Labels for the PVC | `{}` |
| `imagePullSecrets` | Secrets for pulling images | `[]` |
| `service.annotations` | Annotations for the service | See values.yaml |
| `service.type` | Service type | `LoadBalancer` |
| `service.ports` | Ports for the service | See values.yaml |
| `ingress.annotations` | Annotations for the ingress | `{}` |
| `ingress.enabled` | Enable ingress | `false` |
| `ingress.host` | Host for the ingress | `example.com` |
| `configs` | Custom configurations | See values.yaml |
| `cloudwatch.enabled` | Enable CloudWatch | `false` |
| `cloudwatch.image.repository` | CloudWatch image repository | `ghcr.io/arpa-network/node-client` |
| `cloudwatch.image.pullPolicy` | Image pull policy for CloudWatch | `Always` |
| `cloudwatch.image.tag` | Image tag for CloudWatch | `latest` |
| `cloudwatch.resources` | Resources for CloudWatch container | `{}` |
| `cloudwatch.env` | Environment variables for CloudWatch | `[]` |
| `cloudwatch.command` | Command for CloudWatch container | See values.yaml |
| `cloudwatch.args` | Arguments for CloudWatch container | `[]` |
| `node.image.repository` | Node image repository | `ghcr.io/arpa-network/node-client` |
| `node.image.pullPolicy` | Image pull policy for Node | `Always` |
| `node.image.tag` | Image tag for Node | `latest` |
| `node.resources` | Resources for Node container | See values.yaml |
| `node.env` | Environment variables for Node | `[]` |
| `node.command` | Command for Node container | `/app/node-client` |
| `node.args` | Arguments for Node container | `-c=/app/config/operator.yaml` |
| `node.volumeMounts` | Volume mounts for Node container | See values.yaml |
| `nodeSelector` | Node selector for the deployment | `{}` |
| `tolerations` | Tolerations for the deployment | `[]` |
| `affinity` | Affinity for the deployment | `{}` |
| `serviceAccount.create` | Create service account | `true` |
| `serviceAccount.annotations` | Annotations for the service account | `{}` |
| `serviceAccount.name` | Name of the service account | `""` |
| `podAnnotations` | Annotations for the pod | `{}` |
| `podSecurityContext` | Security context for the pod | `{}` |
| `securityContext` | Security context for the container | `{}` |
| `volumes` | Volumes for the pod | `[]` |
| `vmPodScrape.enabled` | Enable VM pod scrape | `false` |

## Custom Configurations

Custom configurations can be provided in the `configs` section. For example:

```yaml
configs:
  operator.yaml: |
    node_committer_rpc_endpoint: "0.0.0.0:50061"
    node_advertised_committer_rpc_endpoint: "143.47.183.136:50061"
    node_management_rpc_endpoint: "0.0.0.0:50091"
    node_management_rpc_token: "c3VwZXJzZWNyZXR0b2tlbg=="
    node_statistics_http_endpoint: "0.0.0.0:50081"
    provider_endpoint: "wss://lb.drpc.org/ogws?network=holesky"
    chain_id: 17000
    is_eigenlayer: true
    controller_address: "0xbF53802722985b01c30C0C065738BcC776Ef5A69"
    controller_relayer_address: "0x4A88f1d5D3ab086763df5967D7560148006eE8b4"
    adapter_address: "0x88ab708e6A43eF8c7ab6a3f24B1F90f52a1682b8"
    data_path: "/app/data/data1.sqlite"
    logger:
      context_logging: false
      log_file_path: /app/data/log/1/
      rolling_file_size: 10 gb
    account:
      keystore:
        password: env
        path: /app/operator_keys/ecdsa_key.json
    listeners:
      - l_type: Block
        interval_millis: 0
        use_jitter: true
      - l_type: NewRandomnessTask
        interval_millis: 0
        use_jitter: true
      - l_type: PreGrouping
        interval_millis: 0
        use_jitter: true
      - l_type: PostCommitGrouping
        interval_millis: 1000
        use_jitter: true
      - l_type: PostGrouping
        interval_millis: 1000
        use_jitter: true
      - l_type: ReadyToHandleRandomnessTask
        interval_millis: 1000
        use_jitter: true
      - l_type: RandomnessSignatureAggregation
        interval_millis: 2000
        use_jitter: false
    time_limits:
      block_time: 12
      dkg_timeout_duration: 40
      randomness_task_exclusive_window: 10
      listener_interval_millis: 1000
      dkg_wait_for_phase_interval_millis: 1000
      provider_polling_interval_millis: 1000
      provider_reset_descriptor:
        interval_millis: 5000
        max_attempts: 17280
        use_jitter: false
      contract_transaction_retry_descriptor:
        base: 2
        factor: 1000
        max_attempts: 3
        use_jitter: true
      contract_view_retry_descriptor:
        base: 2
        factor: 500
        max_attempts: 5
        use_jitter: true
      commit_partial_signature_retry_descriptor:
        base: 2
        factor: 1000
        max_attempts: 5
        use_jitter: false
```

## Updating the Chart

To update the chart with new values, run:

```sh
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
helm upgrade -i arpa p2p-avs/arpa --set key1=value1,key2=value2
```

## Uninstallation

To uninstall/delete the `arpa` deployment:

```sh
helm delete arpa
```

This command removes all the Kubernetes components associated with the chart and deletes the release.

## Notes

- Ensure that your Kubernetes cluster has enough resources for the requested CPU and memory.
- Configure your cloud provider's load balancer to handle the specified annotations if using a `LoadBalancer` service type.
- Review and update security context and volume mounts as necessary for your environment.
