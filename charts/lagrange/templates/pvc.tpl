apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "lagrange.fullname" . }}
  {{- with .Values.pvc.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "lagrange.labels" . | nindent 4 }}
    {{- with .Values.pvc.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: {{ .Values.pvc.storageClassName }}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.size }}
