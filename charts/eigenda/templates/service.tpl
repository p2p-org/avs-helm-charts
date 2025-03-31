apiVersion: v1
kind: Service
metadata:
  name: {{ include "eigenda.fullname" . }}
  {{- with .Values.service.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.service.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  loadBalancerIP: {{ .Values.service.reservedPublicIP }}
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
    app: {{ include "eigenda.fullname" . }}
