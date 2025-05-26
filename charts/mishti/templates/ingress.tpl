{{- if .Values.ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "mishti.fullname" . }}
  labels:
    {{- include "mishti.labels" . | nindent 4 }}
      {{- with .Values.service.labels }}
      {{- toYaml . | nindent 4 }}
    {{- end}}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
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
                name: {{ include "mishti.fullname" . }}
                port:
                  name: performer
{{- end }}
