apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "eigenda.fullname" . }}-g1
  {{- with .Values.pvc.g1.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.pvc.g1.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: {{ .Values.pvc.g1.storageClassName}}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.g1.size }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "eigenda.fullname" . }}-g2
  {{- with .Values.pvc.g2.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.pvc.g2.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: {{ .Values.pvc.g2.storageClassName}}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.g2.size }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "eigenda.fullname" . }}-cache
  {{- with .Values.pvc.cache.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.pvc.cache.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: {{ .Values.pvc.cache.storageClassName}}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.cache.size }}
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: {{ include "eigenda.fullname" . }}-database
  {{- with .Values.pvc.database.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.pvc.database.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  storageClassName: {{ .Values.pvc.database.storageClassName}}
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: {{ .Values.pvc.database.size }}
