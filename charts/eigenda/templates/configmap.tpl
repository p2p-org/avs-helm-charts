apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "eigenda.fullname" . }}-config
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.service.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
data:
  NODE_OPT_IN: "{{ .Values.configs.isNeedOptIn }}"
  NODE_QUORUM: "{{ .Values.configs.quorum | default "0" }}"
  NODE_EXPIRATION_POLL_INTERVAL: "180"
  NODE_CACHE_ENCODED_BLOBS: "true"
  NODE_NUM_WORKERS: "1"
  NODE_DISPERSAL_PORT: "32005"
  NODE_QUORUM_ID_LIST: "0"
  NODE_VERBOSE: "true"
  NODE_RETRIEVAL_PORT: "32004"
  NODE_TIMEOUT: "20s"
  NODE_SRS_ORDER: "268435456"
  NODE_SRS_LOAD: "131072"
  NODE_LOG_LEVEL: debug
  NODE_LOG_FORMAT: text
  NODE_ENABLE_METRICS: "true"
  NODE_METRICS_PORT: "9092"
  NODE_ENABLE_NODE_API: "true"
  NODE_API_PORT: "9091"
  NODE_EIGENDA_SERVICE_MANAGER: {{ .Values.configs.eigendaServiceManager }}
  NODE_BLS_OPERATOR_STATE_RETRIVER: {{ .Values.configs.blsOperatorStateRetriever }}
  NODE_CHURNER_URL: {{ .Values.configs.churnerUrl }}
  NODE_CLIENT_IP_HEADER: x-real-ip
  NODE_PUBLIC_IP_PROVIDER: "seeip"
  NODE_PUBLIC_IP_CHECK_INTERVAL: "0s"
  NODE_HOSTNAME: {{ .Values.configs.nodeHostName }}
  NODE_CHAIN_RPC: {{ .Values.configs.nodeChainRPC }}
  NODE_CHAIN_ID: "{{ .Values.configs.nodeChainID }}"
  NODE_ECDSA_KEY_FILE: "/app/operator_keys/ecdsa/ecdsa_key.json"
  NODE_BLS_KEY_FILE: "/app/operator_keys/bls/bls_key.json"
  NODE_G1_PATH: "/app/g1/g1.point"
  NODE_G2_POWER_OF_2_PATH: "/app/g2/g2.point.powerOf2"
  NODE_CACHE_PATH: "/app/cache"
  NODE_DB_PATH: "/data/operator/db"
  NODE_PRIVATE_KEY: ""
  NODE_REACHABILITY_POLL_INTERVAL: "60"
  NODE_DATAAPI_URL: "https://dataapi.eigenda.xyz"
