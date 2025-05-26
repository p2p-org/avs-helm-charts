apiVersion: v1
kind: ConfigMap
metadata:
  name: eoracle-config
  namespace: {{ .Values.namespace }}
data:
  EO_CHAIN_RPC_ENDPOINT: {{ .Values.configMap.jsonRPCEndpoint }}
  EO_CHAIN_WS_ENDPOINT: {{ .Values.configMap.jsonWSEndpoint }}
  EO_REGISTRY_COORDINATOR: {{ .Values.configMap.registryCoordinator }}
  EO_CCDATA_API_KEY: {{ .Values.configMap.ccdata_api_key | default "" }}
  EO_STAKE_REGISTRY: {{ .Values.configMap.stakeRegitry }}
  EO_CONFIG_ADDRESS: {{ .Values.configMap.configAddress }}
  EO_AGGREGATOR_ADDRESS: {{ .Values.configMap.aggregatorAddress }}
  ETH_RPC_ENDPOINT: {{ .Values.configMap.ethRPC }}
  ETHEREUM_FEED_RPC_ENDPOINT: {{ .Values.configMap.ethRPC }}
  EO_LOGGING_LEVEL: "info"
  EO_KEYSTORE_PATH: ".keystore"
  EO_PROMETHEUS_PORT: "10004"
  EO_HEALTH_ENDPOINTS_PORT: "10003"
  MERLIN_FEED_RPC_ENDPOINT: https://rpc.merlinchain.io
  TRX_FEED_RPC_ENDPOINT: https://api.trongrid.io
  BITLAYER_FEED_RPC_ENDPOINT: https://rpc.bitlayer-rpc.com
  BSC_FEED_RPC_ENDPOINT: https://rpc-bsc.48.club