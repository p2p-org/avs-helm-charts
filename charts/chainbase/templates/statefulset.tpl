apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "chainbase.fullname" . }}
  labels:
    {{- include "chainbase.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "chainbase.selectorLabels" . | nindent 6 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 6 }}
        {{- end}}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        app: {{ include "chainbase.fullname" . }}
        {{- include "chainbase.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      hostAliases:
      - ip: "127.0.0.1"
        hostnames:
        - "jobmanager"
        - "taskmanager"
        - "node"
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "chainbase.fullname" .) }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      initContainers:
      {{- if .Values.common.initContainer.enabled }}
        - name: node-init
          {{- if .Values.common.initContainer.command }}
          {{- with .Values.common.initContainer.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.common.initContainer.args }}
          {{- with .Values.common.initContainer.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.common.initContainer.image.repository }}:{{ .Values.common.initContainer.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.common.initContainer.image.pullPolicy }}
          {{- with .Values.common.initContainer.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.common.initContainer.env | nindent 12 }}
      {{- end }}
      containers:
        - name: node
          {{- if .Values.node.command }}
          {{- with .Values.node.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.node.args }}
          {{- with .Values.node.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.node.image.repository }}:{{ .Values.node.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.node.image.pullPolicy }}
          {{- if .Values.node.ports }}
          ports:
          {{- toYaml $.Values.node.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.node.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.node.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.node.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.node.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.node.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.node.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
        - name: jobmanager
          {{- if .Values.jobmanager.command }}
          {{- with .Values.jobmanager.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.jobmanager.args }}
          {{- with .Values.jobmanager.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.jobmanager.image.repository }}:{{ .Values.jobmanager.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.jobmanager.image.pullPolicy }}
          {{- if .Values.jobmanager.ports }}
          ports:
          {{- toYaml $.Values.jobmanager.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.jobmanager.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.jobmanager.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.jobmanager.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.jobmanager.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.jobmanager.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.jobmanager.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.jobmanager.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.jobmanager.env | nindent 12 }}
        - name: shell
          {{- if .Values.shell.command }}
          {{- with .Values.shell.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.shell.args }}
          {{- with .Values.shell.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.shell.image.repository }}:{{ .Values.shell.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.shell.image.pullPolicy }}
          {{- if .Values.shell.ports }}
          ports:
          {{- toYaml $.Values.shell.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.shell.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.shell.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.shell.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.shell.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.shell.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.shell.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.shell.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.shell.env | nindent 12 }}

        - name: taskmanager
          {{- if .Values.taskmanager.command }}
          {{- with .Values.taskmanager.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.taskmanager.args }}
          {{- with .Values.taskmanager.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.taskmanager.image.repository }}:{{ .Values.taskmanager.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.taskmanager.image.pullPolicy }}
          {{- if .Values.taskmanager.ports }}
          ports:
          {{- toYaml $.Values.taskmanager.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.taskmanager.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.taskmanager.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.taskmanager.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.taskmanager.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.taskmanager.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.taskmanager.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.taskmanager.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.taskmanager.env | nindent 12 }}
      volumes:
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}
        - name: config
          configMap:
            name: {{ include "chainbase.fullname" . }}-config

      {{- with .Values.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
