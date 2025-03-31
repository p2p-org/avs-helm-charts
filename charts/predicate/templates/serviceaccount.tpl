{{- if .Values.serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ .Values.serviceAccount.name | default (include "predicate.fullname" .) }}
  labels:
    {{- include "predicate.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- end }}
