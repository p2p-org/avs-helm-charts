apiVersion: v1
kind: Service
metadata:
  name: {{ include "langrange.fullname" . }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "langrange.labels" . | nindent 4 }}
    {{- with .Values.service.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  type: {{ .Values.service.type }}
  ports:
  {{- range .Values.service.ports }}
  - name: {{ .name }}
    port: {{ .port }}
    protocol: {{ .protocol }}
    targetPort: {{ .targetPort }}
  {{- end }}
  selector:
    {{- with .Values.labels }}
      {{- toYaml . | nindent 4 }}
    {{- end}}
    app: {{ include "langrange.fullname" . }}
