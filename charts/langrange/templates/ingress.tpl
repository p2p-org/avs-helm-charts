{{- if .Values.ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "langrange.fullname" . }}
  labels:
    {{- include "langrange.labels" . | nindent 4 }}
      {{- with .Values.service.labels }}
      {{- toYaml . | nindent 4 }}
    {{- end}}
  annotations:
  {{- with .Values.ingress.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end}}
spec:
  ingressClassName: nginx
  rules:
    - host: {{ .Values.ingress.host }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: {{ include "langrange.fullname" . }}
                port:
                  name: node-api
{{- end }}
