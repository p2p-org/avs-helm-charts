{{- if .Values.register.enabled }}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ include "ungate.fullname" . }}-register-job
  labels:
    {{- include "ungateRegister.labels" . | nindent 4 }}
  annotations:
    "helm.sh/hook": "post-install"
spec:
  template:
    metadata:
      labels:
        {{- include "ungateRegister.labels" . | nindent 8 }}
    spec:

      initContainers:
        - name: register-init
          {{- with .Values.register.initContainer.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.register.initContainer.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.register.initContainer.image.repository }}:{{ .Values.register.initContainer.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.initContainer.image.pullPolicy }}
          {{- with .Values.register.initContainer.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.register.initContainer.env | nindent 12 }}
      containers:
        - name: register
          image: "{{ .Values.register.image.repository }}:{{ .Values.register.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.register.image.pullPolicy }}
          args:
            {{- toYaml .Values.register.args | nindent 12 }}
          env:
            {{- toYaml .Values.register.env | nindent 12 }}
          volumeMounts:
            {{- toYaml .Values.register.volumeMounts | nindent 12 }}
      restartPolicy: Never
      volumes:
        {{- toYaml .Values.volumes | nindent 8 }}
        - name: config
          configMap:
            name: {{ include "ungate.fullname" . }}-config
  backoffLimit: 2
{{ end }}