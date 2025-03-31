apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "predicate.fullname" . }}
  labels:
    {{- include "predicate.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "predicate.selectorLabels" . | nindent 6 }}
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
        app: {{ include "predicate.fullname" . }}
        {{- include "predicate.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "predicate.fullname" .) }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
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

        - name: node
          {{- with .Values.node.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.node.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.node.image.repository }}:{{ .Values.node.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.node.image.pullPolicy }}
          ports:
          {{- toYaml $.Values.node.ports | nindent 10 }}
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
      volumes:
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}
        - name: config
          configMap:
            name: {{ include "predicate.fullname" . }}-config

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
