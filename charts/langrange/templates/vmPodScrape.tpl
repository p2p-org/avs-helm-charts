{{- if .Values.vmPodScrape.enabled -}}
apiVersion: operator.victoriametrics.com/v1beta1
kind: VMPodScrape
metadata:
  name: {{ include "langrange.fullname" . }}
spec:
  selector:
    matchLabels:
      {{- include "langrange.selectorLabels" . | nindent 6 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 6 }}
        {{- end}}
  podMetricsEndpoints:
    - port: metrics
      scheme: http
{{- end }}
