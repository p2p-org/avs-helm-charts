# k3 Helm Chart

## Introduction
This repository contains a Helm chart for Kubernetes, specifically for the AVS named "k3".   
More information about k3 you can find here `https://docs.k3-labs.com/introduction/tech-documentation/operator-onboarding`

## Table of Contents
- [k3 Helm Chart](#k3-helm-chart)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Features](#features)
  - [Configuration](#configuration)
  - [Dependencies](#dependencies)
  - [Examples](#examples)
  - [Troubleshooting](#troubleshooting)
  - [Contributors](#contributors)
  - [License](#license)

## Installation
To install the chart with the release name `my-release`:

```sh
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
helm install my-release p2p-avs/k3
```

## Usage
To use this chart, you can override default values by providing your own `values.yaml` file:

```sh
helm install my-release p2p-avs/k3 -f values.yaml
```

## Features
- Deployment of the `k3` application
- Configurable service types and ports
- Customizable ingress settings
- Node-specific configurations and environment variables
- Support for custom image repositories and tags
- Probes for readiness checks

## Configuration
The following table lists the configurable parameters of the k3 chart and their default values.

| Parameter                   | Description                                                   | Default                      |
|-----------------------------|---------------------------------------------------------------|------------------------------|
| `replicaCount`              | Number of replicas                                            | `1`                          |
| `service.type`              | Type of Kubernetes service                                    | `ClusterIP`                  |
| `service.ports`             | Service ports                                                 | `{...}`                      |
| `ingress.enabled`           | Enable ingress                                                | `false`                      |
| `ingress.host`              | Ingress host                                                  | `example.com`                |
| `node.image.repository`     | Node image repository                                         | `k3official/k3-labs-avs-operator` |
| `node.image.tag`            | Node image tag                                                | `latest`                     |
| `node.image.pullPolicy`     | Image pull policy                                             | `Always`                     |
| `node.resources.requests`   | CPU/Memory resource requests                                  | `2 CPU / 8Gi Memory`         |
| `node.resources.limits`     | CPU/Memory resource limits                                    | `4 CPU / 16Gi Memory`        |
| `serviceAccount.create`     | Specifies whether a service account should be created         | `true`                       |
| `serviceAccount.name`       | Name of the service account                                   | `""`                         |
| `vmPodScrape.enabled`       | Enable VM Pod scraping                                        | `true`                       |
| `register.enabled`          | Enable register functionality                                 | `true`                       |
| `register.image.repository` | Register image repository                                     | `k3official/k3-labs-avs-operator` |
| `register.image.tag`        | Register image tag                                            | `latest`                     |
| `register.image.pullPolicy` | Register image pull policy                                    | `Always`                     |
| `configs.operator.yaml`     | Operator configuration                                        | `empty`                      |

## Dependencies
This chart depends on several Kubernetes resources and should be used in a Kubernetes cluster. Ensure that you have Kubernetes and Helm installed and configured in your environment.

## Examples
Here is an example of how to configure the `values.yaml` for your deployment:

```yaml
replicaCount: 2

service:
  type: LoadBalancer
  ports:
    - name: http
      port: 80
      targetPort: 80

ingress:
  enabled: true
  host: myapp.example.com

node:
  image:
    repository: myrepo/myapp
    tag: "1.0.0"
  resources:
    limits:
      cpu: "2"
      memory: "4Gi"
    requests:
      cpu: "1"
      memory: "2Gi"
```

## Troubleshooting
If you encounter any issues during installation or usage, check the following:

- Ensure that all required Kubernetes resources are available.
- Validate your `values.yaml` file against the provided `values.schema.json`.
- Check the logs of the Helm deployment for any errors.

## Contributors
- xom4ek (Aleksei Lazarev) - aleksei.lazarev@p2p.org

## License
This project is licensed under the MIT License. See the LICENSE file for details.