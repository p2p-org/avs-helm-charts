# Automata Helm Chart

## Introduction

This repository contains a Helm chart for Kubernetes, specifically for the AVS named "Automata".  
More information about Automata you can find here `https://github.com/automata-network/multi-prover-avs`

## Table of Contents

- [Automata Helm Chart](#Automata-helm-chart)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Usage](#usage)
    - [Steps to Follow:](#steps-to-follow)
  - [Configuration](#configuration)
  - [Dependencies](#dependencies)
  - [Troubleshooting](#troubleshooting)
  - [Contributors](#contributors)
  - [License](#license)

## Usage

### Steps to Follow:

1. Generate keys via the following URLs:

   - [Eigenlayer Operator Installation Guide](https://docs.eigenlayer.xyz/eigenlayer/operator-guides/operator-installation)
   - [Automata Configs](https://github.com/automata-network/multiprover-avs-operator-setup)

2. Create a secret in Kubernetes for any workflow you want. Example you can find in `./examples`

   > Dont use secret in open way, try to figure out with [vault](https://github.com/hashicorp/vault) / [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) / [sops](https://github.com/getsops/sops)

3. Fill the placeholders in your `values.yaml` file:

   - `YOUR_OPERATOR_ADDRESS`
   - `YOUR_BLS_KEY_SECRET`
   - `YOUR_ECDSA_KEY_SECRET`

4. Run the following command to upgrade and install the chart:
   ```sh
   helm upgrade -i automata p2p-avs/automata -f values.yaml
   ```

Registration must be pass automatically via job register

## Configuration

The following table lists the configurable parameters of the ava chart and their default values.

| Parameter                   | Description                                           | Default               |
| --------------------------- | ----------------------------------------------------- | --------------------- |
| `replicaCount`              | Number of replicas                                    | `1`                   |
| `service.type`              | Type of Kubernetes service                            | `ClusterIP`           |
| `service.ports`             | Service ports                                         | `{...}`               |
| `ingress.enabled`           | Enable ingress                                        | `false`               |
| `ingress.host`              | Ingress host                                          | `example.com`         |
| `node.image.repository`     | Node image repository                                 | `avaprotocol/ap-avs`  |
| `node.image.tag`            | Node image tag                                        | `latest`              |
| `node.image.pullPolicy`     | Image pull policy                                     | `Always`              |
| `node.resources.requests`   | CPU/Memory resource requests                          | `2 CPU / 8Gi Memory`  |
| `node.resources.limits`     | CPU/Memory resource limits                            | `4 CPU / 16Gi Memory` |
| `serviceAccount.create`     | Specifies whether a service account should be created | `true`                |
| `serviceAccount.name`       | Name of the service account                           | `"automata"`          |
| `vmPodScrape.enabled`       | Enable VM Pod scraping                                | `true`                |
| `configs.operator.json`     | Operator configuration                                | `{}`                  |

## Dependencies

This chart depends on several Kubernetes resources and should be used in a Kubernetes cluster. Ensure that you have Kubernetes and Helm installed and configured in your environment.

## Troubleshooting

If you encounter any issues during installation or usage, check the following:

- Ensure that all required Kubernetes resources are available.
- Validate your `values.yaml` file against the provided `values.schema.json`.
- Check the logs of the Helm deployment for any errors.

## Contributors

- vkuzenkov (Viktor Kuzenkov) viktor.k@p2p.org

## License

This project is licensed under the MIT License. See the LICENSE file for details.
