apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "ungate.fullname" . }}-config
  labels:
    {{- include "ungate.labels" . | nindent 4 }}
    {{- with .Values.service.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
data:
  {{- if .Values.configs }}
    {{- toYaml .Values.configs | nindent 2 }}
  {{- end }}
