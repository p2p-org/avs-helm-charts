# Arpa Helm Chart

## Introduction
This repository contains a Helm chart for Kubernetes, specifically for the AVS named "arpa".   
More information about arpa you can find here [arpa-onboarding](https://github.com/ARPA-Network/BLS-TSS-Network/blob/main/docs/eigenlayer-onboarding.md).

## Table of Contents
- [Arpa Helm Chart](#arpa-helm-chart)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
    - [Steps to Follow:](#steps-to-follow)
    - [Registration](#registration)
  - [Configuration](#configuration)
  - [Dependencies](#dependencies)
  - [Troubleshooting](#troubleshooting)
  - [Contributors](#contributors)
  - [License](#license)

## Usage
To use this chart, you can override default values by providing your own `values.yaml` file:

```sh
helm install arpa p2p-avs/arpa -f values.yaml
```

### Steps to Follow:
1. Generate keys via the following URLs:
   - [Eigenlayer Operator Installation Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation)
   - [Arpa Configs](https://github.com/0xJomo/arpa-configs)

2. Create a secret in Kubernetes for any workflow you want. Example you can find in `./examples`

3. Fill the placeholders in your `values.yaml` file:
   - `YOUR_OPERATOR_ADDRESS`
   - `YOUR_ECDSA_SIGN_KEY_SECRET`
   - `YOUR_BLS_KEY_SECRET`
   - `YOUR_ECDSA_KEY_SECRET`

4. Run the following command to upgrade and install the chart:
   ```sh
   helm upgrade -i arpa p2p-avs/arpa -f values.yaml
   ```

### Registration
After installation, you need to login to the job and perform the registration:

```sh
kubectl get pods # Find your pods
kubectl exec -it $POD_NAME -c node-shell -- sh
node-shell --config-path=/app/config/operator.yaml
send register-as-eigenlayer-operator /app/operator_keys/ecdsa_key.json $ARPA_NODE_ACCOUNT_KEYSTORE_PASSWORD
```

## Configuration
The following table lists the configurable parameters of the arpa chart and their default values.

| Parameter                   | Description                                                   | Default                      |
|-----------------------------|---------------------------------------------------------------|------------------------------|
| `replicaCount`              | Number of replicas                                            | `1`                          |
| `service.type`              | Type of Kubernetes service                                    | `ClusterIP`                  |
| `service.ports`             | Service ports                                                 | `{...}`                      |
| `ingress.enabled`           | Enable ingress                                                | `false`                      |
| `ingress.host`              | Ingress host                                                  | `example.com`                |
| `node.image.repository`     | Node image repository                                         | `ghcr.io/arpa-network/node-client` |
| `node.image.tag`            | Node image tag                                                | `latest`                     |
| `node.image.pullPolicy`     | Image pull policy                                             | `Always`                     |
| `node.resources.requests`   | CPU/Memory resource requests                                  | `2 CPU / 8Gi Memory`         |
| `node.resources.limits`     | CPU/Memory resource limits                                    | `4 CPU / 16Gi Memory`        |
| `serviceAccount.create`     | Specifies whether a service account should be created         | `true`                       |
| `serviceAccount.name`       | Name of the servisce account                                   | `""`                         |
| `vmPodScrape.enabled`       | Enable VM Pod scraping                                        | `true`                       |
| `nodeShell.enabled`          | Enable nodeShell functionality                                 | `true`                       |
| `nodeShell.image.repository` | nodeShell image repository                                     | `ghcr.io/arpa-network/node-client` |
| `nodeShell.image.tag`        | nodeShell image tag                                            | `latest`                     |
| `nodeShell.image.pullPolicy` | nodeShell image pull policy                                    | `Always`                     |
| `configs.operator.yaml`     | Operator configuration                                        | `empty`                      |

## Dependencies
This chart depends on several Kubernetes resources and should be used in a Kubernetes cluster. Ensure that you have Kubernetes and Helm installed and configured in your environment.

## Troubleshooting
If you encounter any issues during installation or usage, check the following:

- Ensure that all required Kubernetes resources are available.
- Validate your `values.yaml` file against the provided `values.schema.json`.
- Check the logs of the Helm deployment for any errors.

## Contributors
- xom4ek (Aleksei Lazarev) - aleksei.lazarev@p2p.org

## License
This project is licensed under the MIT License. See the LICENSE file for details.
