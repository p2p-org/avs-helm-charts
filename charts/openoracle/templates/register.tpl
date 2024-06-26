apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "openoracle.fullname" . }}-register-job
  labels:
    {{- include "openoracleRegister.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": "post-install"
spec:
  template:
    metadata:
      labels:
        {{- include "openoracleRegister.labels" . | nindent 8 }}
    spec:
      containers:
        - name: register
          image: "{{ .Values.register.image.repository }}:{{ .Values.register.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.image.pullPolicy }}
          args:
            {{- toYaml .Values.register.args | nindent 12 }}
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
          volumeMounts:
            {{- toYaml .Values.node.volumeMounts | nindent 12 }}
      restartPolicy: Never
      volumes:
        {{- if .Values.volumes }}
        {{- toYaml .Values.volumes | nindent 8 }}
        {{- end }}
        - name: config
          configMap:
            name: {{ include "openoracle.fullname" . }}-config
  backoffLimit: 2
