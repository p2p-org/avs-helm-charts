apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "mishti.fullname" . }}
  labels:
    {{- include "mishti.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "mishti.selectorLabels" . | nindent 6 }}
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
        app: {{ include "mishti.fullname" . }}
        {{- include "mishti.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "mishti.fullname" .) }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      initContainers:
        - name: node-init
          {{- with .Values.common.initContainer.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.common.initContainer.args }}
          args:
          {{- toYaml . | nindent 12 }}
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
      containers:
        - name: prover
          {{- with .Values.prover.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.prover.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.prover.image.repository }}:{{ .Values.prover.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.prover.image.pullPolicy }}
          {{- if .Values.prover.ports }}
          ports:
          {{- toYaml $.Values.prover.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.prover.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.prover.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.prover.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.prover.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.prover.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.prover.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.prover.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            - name: NODE_TYPE
              value: Prover
            {{- toYaml .Values.prover.env | nindent 12 }}
        - name: verifier
          {{- with .Values.verifier.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.verifier.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.verifier.image.repository }}:{{ .Values.verifier.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.verifier.image.pullPolicy }}
          {{- if .Values.verifier.ports }}
          ports:
          {{- toYaml $.Values.verifier.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.verifier.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.verifier.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.verifier.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.verifier.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.verifier.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.verifier.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.verifier.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.verifier.env | nindent 12 }}
        - name: attester
          {{- with .Values.attester.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.attester.args }}
          args:
          {{- toYaml . | nindent 12 }}
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
        - name: aggregator
          {{- with .Values.aggregator.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.aggregator.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.aggregator.image.repository }}:{{ .Values.aggregator.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.aggregator.image.pullPolicy }}
          {{- if .Values.aggregator.ports }}
          ports:
          {{- toYaml $.Values.aggregator.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.aggregator.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.aggregator.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.aggregator.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.aggregator.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.aggregator.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.aggregator.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.aggregator.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.aggregator.env | nindent 12 }}
        - name: relay
          {{- with .Values.relay.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.relay.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.relay.image.repository }}:{{ .Values.relay.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.relay.image.pullPolicy }}
          {{- if .Values.relay.ports }}
          ports:
          {{- toYaml $.Values.relay.ports | nindent 10 }}
          {{- end }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.relay.lifecycleHooks | nindent 12 }}
          {{- end }}
          {{- if .Values.relay.livenessProbe }}
          livenessProbe:
            {{- toYaml .Values.relay.livenessProbe | nindent 12 }}
          {{- end }}
          {{- if .Values.relay.readinessProbe }}
          readinessProbe:
            {{- toYaml .Values.relay.readinessProbe | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.relay.resources | nindent 12 }}
          volumeMounts:
          {{- with .Values.relay.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            - name: NODE_TYPE
              value: Relay
            {{- toYaml .Values.relay.env | nindent 12 }}
      volumes:
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}
        - name: config
          configMap:
            name: {{ include "mishti.fullname" . }}-config

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
