apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "ungate.fullname" . }}
  labels:
    {{- include "ungate.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "ungate.selectorLabels" . | nindent 6 }}
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
        app: {{ include "ungate.fullname" . }}
        {{- include "ungate.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "ungate.fullname" .) }}
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
        - name: attester
          {{- if .Values.attester.command }}
          {{- with .Values.attester.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.attester.args }}
          {{- with .Values.attester.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.attester.image.repository }}:{{ .Values.attester.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.attester.image.pullPolicy }}
          {{- if .Values.attester.ports }}
          ports:
          {{- toYaml $.Values.attester.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.attester.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.attester.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.attester.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.attester.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.attester.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.attester.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.attester.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.attester.env | nindent 12 }}
        - name: avswebapi
          {{- if .Values.avswebapi.command }}
          {{- with .Values.avswebapi.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          {{- if .Values.avswebapi.args }}
          {{- with .Values.avswebapi.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.avswebapi.image.repository }}:{{ .Values.avswebapi.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.avswebapi.image.pullPolicy }}
          {{- if .Values.avswebapi.ports }}
          ports:
          {{- toYaml $.Values.avswebapi.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.avswebapi.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.avswebapi.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.avswebapi.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.avswebapi.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.avswebapi.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.avswebapi.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.avswebapi.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.avswebapi.env | nindent 12 }}
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

      volumes:
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}
        - name: config
          configMap:
            name: {{ include "ungate.fullname" . }}-config

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
