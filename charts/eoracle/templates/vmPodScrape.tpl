apiVersion: operator.victoriametrics.com/v1beta1
kind: VMPodScrape
metadata:
  name: eoracle-node
  namespace: {{ .Values.namespace }}
spec:
  selector:
    matchLabels:
      k8s-app: eoracle
  podMetricsEndpoints:
    - port: metrics
      scheme: http