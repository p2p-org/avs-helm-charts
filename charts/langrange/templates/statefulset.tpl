apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "langrange.fullname" . }}
  labels:
    {{- include "langrange.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
  annotations:
    {{- with .Values.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "langrange.selectorLabels" . | nindent 6 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 6 }}
        {{- end}}
  template:
    metadata:
      annotations:
      {{- with .Values.podAnnotations }}
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.annotations }}
        {{- toYaml . | nindent 8 }}
      {{- end}}
      labels:
        app: {{ include "langrange.fullname" . }}
        {{- include "langrange.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "langrange.fullname" .) }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
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
            - name: config
              mountPath: /app/config/operator.yaml
              subPath: operator.yaml
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
      volumes:
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}
        - name: config
          configMap:
            name: {{ include "langrange.fullname" . }}-config

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
