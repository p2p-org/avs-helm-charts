apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "k3.fullname" . }}-config
  labels:
    {{- include "k3.labels" . | nindent 4 }}
    {{- with .Values.service.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
data:
  {{- if .Values.configs }}
    {{- toYaml .Values.configs | nindent 2 }}
  {{- end }}
