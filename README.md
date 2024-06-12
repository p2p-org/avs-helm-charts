<p align="center">
    <img width="400px" height=auto src="https://raw.githubusercontent.com/p2p-org/eigenlayer-operator/main/logo.png" />
</p>

<p align="center">
    <a href="https://x.com/P2Pvalidator"><img src="https://badgen.net/badge/twitter/@P2Pvalidator/1DA1F2?icon&label" /></a>
    <a href="https://github.com/p2p-org/avs-helm-charts"><img src="https://badgen.net/github/stars/p2p-org/avs-helm-charts?icon=github" /></a>
    <a href="https://github.com/p2p-org/avs-helm-charts"><img src="https://badgen.net/github/forks/p2p-org/avs-helm-charts?icon=github" /></a>
</p>

## P2P Helm Charts for Kubernetes

This repository offers a selection of carefully curated P2P Helm charts, which are stored in individual folders. Each chart has its own `values.yaml` file defining the configuration parameters.

## Getting Started

To use these Helm charts, you first need to add the P2P repository to your local Helm client:

```bash
helm repo add p2p-avs https://p2p-org.github.io/avs-helm-charts/
```

Once the repository is added, you can deploy a specific chart with the following command:

```bash
helm install my-release p2p-avs/<chart-name>
```

**Note:** Make sure to replace `<chart-name>` with the name of the actual chart you intend to install.

## Requirements

Before you can use these Helm charts, ensure you have the following:

* Kubernetes 1.20 or higher
* Helm 3
* PV provisioner support in the underlying infrastructure (required for some charts)

## Using Helm

After installing the Helm client and adding the P2P repository, Helm is your tool of choice to manage packages on your Kubernetes cluster. For detailed guidance on using Helm, see the [official documentation](https://helm.sh/docs/intro/using_helm/).

Here's a selection of helpful Helm commands to kickstart your journey:

* Install a chart: `helm install my-release p2p-avs/<chart-name>`
* Upgrade your application: `helm upgrade my-release p2p-avs/<chart-name>`

## Contribute

We welcome contributions to improve our Helm charts. If you discover any bugs, have issues, or ideas for enhancements, feel free to open an issue or submit a pull request. Every feedback, bug report, or feature request is invaluable to us, and we appreciate the community's involvement in making P2P's Helm charts better.

Feel free to explore the repository and experiment with the Helm charts to suit your specific needs. P2P's Helm charts aim to make application deployment on Kubernetes an effortless experience.
