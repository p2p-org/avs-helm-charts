apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "eigenda.fullname" . }}
  labels:
    {{- include "eigenda.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end}}
spec:
  replicas: 1
  selector:
    matchLabels:
      {{- include "eigenda.selectorLabels" . | nindent 6 }}
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
        app: {{ include "eigenda.fullname" . }}
        {{- include "eigenda.selectorLabels" . | nindent 8 }}
        {{- with .Values.labels }}
        {{- toYaml . | nindent 8 }}
        {{- end}}
    spec:
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ .Values.serviceAccount.name | default (include "eigenda.fullname" .) }}
      securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: node-shell
          envFrom:
            - configMapRef:
                name: {{ include "eigenda.fullname" . }}-config
          {{- with .Values.node.envFrom }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.nodeShell.command }}
          command:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          {{- with .Values.nodeShell.args }}
          args:
          {{- toYaml . | nindent 12 }}
          {{- end }}
          securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.nodeShell.image.repository }}:{{ .Values.nodeShell.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.nodeShell.image.pullPolicy }}
          {{- if .Values.lifecycleHooks }}
          lifecycle:
          {{- toYaml .Values.nodeShell.lifecycleHooks | nindent 12 }}
          {{- end }}
          resources:
            {{- toYaml .Values.nodeShell.resources | nindent 12 }}
          volumeMounts:
            - name: eigenda-g1
              mountPath: /app/g1
            - name: eigenda-g2
              mountPath: /app/g2
            - name: eigenda-cache
              mountPath: /app/cache
            - name: eigenda-db
              mountPath: /data/operator/db
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
        - name: node
          envFrom:
            - configMapRef:
                name: {{ include "eigenda.fullname" . }}-config
          {{- with .Values.node.envFrom }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
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
            - name: eigenda-g1
              mountPath: /app/g1
            - name: eigenda-g2
              mountPath: /app/g2
            - name: eigenda-cache
              mountPath: /app/cache
            - name: eigenda-db
              mountPath: /data/operator/db
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
            {{- toYaml .Values.node.env | nindent 12 }}
      initContainers:
        - name: eigenda-g1-downloader
          image: "{{ .Values.busybox.image.repository }}:{{ .Values.busybox.image.tag | default .Chart.AppVersion }}"
          command:
            [
              "sh",
              "-c",
              "if ! [ -f /app/g1/g1.point ]; then wget https://srs-mainnet.s3.amazonaws.com/kzg/g1.point --output-document=/app/g1/g1.point; fi",
            ]
          volumeMounts:
            - name: eigenda-g1
              mountPath: /app/g1
            - name: eigenda-g2
              mountPath: /app/g2
            - name: eigenda-cache
              mountPath: /app/cache
            - name: eigenda-db
              mountPath: /data/operator/db
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
        - name: eigenda-g2-downloader
          image: "{{ .Values.busybox.image.repository }}:{{ .Values.busybox.image.tag | default .Chart.AppVersion }}"
          command:
            [
              "sh",
              "-c",
              "if ! [ -f /app/g2/g2.point.powerOf2 ]; then wget https://srs-mainnet.s3.amazonaws.com/kzg/g2.point.powerOf2 --output-document=/app/g2/g2.point.powerOf2; fi",
            ]
          volumeMounts:
            - name: eigenda-g1
              mountPath: /app/g1
            - name: eigenda-g2
              mountPath: /app/g2
            - name: eigenda-cache
              mountPath: /app/cache
            - name: eigenda-db
              mountPath: /data/operator/db
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
        - name: eigenda-opt-in
          image: "{{ .Values.optIn.image.repository }}:{{ .Values.optIn.image.tag | default .Chart.AppVersion }}"
          envFrom:
            - configMapRef:
                name: {{ include "eigenda.fullname" . }}-config
          {{- with .Values.node.envFrom }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          env:
          {{- with .Values.node.env }}
          {{- toYaml . | nindent 12 }}
          {{- end }}
          command:
            [
              "sh",
              "-c",
              'if $NODE_OPT_IN; then nodeplugin --ecdsa-key-password $NODE_ECDSA_KEY_PASSWORD --bls-key-password $NODE_BLS_KEY_PASSWORD --operation opt-in --socket "$NODE_HOSTNAME:$NODE_DISPERSAL_PORT;$NODE_RETRIEVAL_PORT" --quorum-id-list $NODE_QUORUM; fi',
            ]
          volumeMounts:
            - name: eigenda-g1
              mountPath: /app/g1
            - name: eigenda-g2
              mountPath: /app/g2
            - name: eigenda-cache
              mountPath: /app/cache
            - name: eigenda-db
              mountPath: /data/operator/db
          {{- with .Values.node.volumeMounts }}
          {{- toYaml . | nindent 12 }}
          {{- end }}


      volumes:
        - name: eigenda-g1
          persistentVolumeClaim:
            claimName: {{ include "eigenda.fullname" . }}-g1
        - name: eigenda-g2
          persistentVolumeClaim:
            claimName: {{ include "eigenda.fullname" . }}-g2
        - name: eigenda-cache
          persistentVolumeClaim:
            claimName: {{ include "eigenda.fullname" . }}-cache
        - name: eigenda-database
          persistentVolumeClaim:
            claimName: {{ include "eigenda.fullname" . }}-database
          {{- with .Values.volumes }}
          {{- toYaml . | nindent 8 }}
          {{- end }}

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
