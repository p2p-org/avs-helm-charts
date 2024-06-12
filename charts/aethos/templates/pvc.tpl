apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "aethos.fullname" . }}
  {{- with .Values.pvc.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "aethos.labels" . | nindent 4 }}
    {{- with .Values.pvc.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: oci-bv
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.size }}
