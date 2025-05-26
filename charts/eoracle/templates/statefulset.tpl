apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: eoracle
  namespace: {{ .Values.namespace }}
  labels:
    k8s-app: eoracle
spec:
  serviceName: "eoracle-node"
  selector:
    matchLabels:
      k8s-app: eoracle
  replicas: 1
  template:
    metadata:
      labels:
        k8s-app: eoracle
    spec:
      containers:
        - name: eoracle-node
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          envFrom:
            - configMapRef:
                name: eoracle-config
          env:
            - name: EO_PASSPHRASE
              valueFrom:
                secretKeyRef:
                  name: eoracle-ecdsa-key
                  key: ecdsa-private-key-password
          ports:
            - name: metrics
              containerPort: 10004
              protocol: TCP
          command:
            [
              "sh",
              "-c",
              "mkdir -p /app/.keystore && cp /app/keystore/*.json /app/.keystore && data-validator"
            ]
          volumeMounts:
            - name: eoracle-ecdsa-key-file
              mountPath: /app/keystore/ecdsaEncryptedWallet.json
              subPath: ecdsaEncryptedWallet.json
              readOnly: true
            - name: eoracle-aliased-ecdsa-key-file
              mountPath: /app/.keystore/ecdsaAliasedEncryptedWallet.json
              subPath: ecdsaAliasedEncryptedWallet.json
              readOnly: true
            - name: eoracle-bls-key-file
              mountPath: /app/keystore/blsEncryptedWallet.json
              subPath: blsEncryptedWallet.json
              readOnly: true
        - name: eoracle-nodeshell
          image: mirror.gcr.io/eoracle/opr_cli:latest
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          envFrom:
            - configMapRef:
                name: eoracle-config
          env:
            - name: EO_PASSPHRASE
              valueFrom:
                secretKeyRef:
                  name: eoracle-ecdsa-key
                  key: ecdsa-private-key-password
          command: [ "sleep", "infinity" ]
          volumeMounts:
            - name: eoracle-ecdsa-key-file
              mountPath: /app/eoracle/.keystore/ecdsaEncryptedWallet.json
              subPath: ecdsaEncryptedWallet.json
              readOnly: true
            - name: eoracle-aliased-ecdsa-key-file
              mountPath: /app/eoracle/.keystore/ecdsaAliasedEncryptedWallet.json
              subPath: ecdsaAliasedEncryptedWallet.json
              readOnly: true
            - name: eoracle-bls-key-file
              mountPath: /app/eoracle/.keystore/blsEncryptedWallet.json
              subPath: blsEncryptedWallet.json
              readOnly: true
      volumes:
        - name: eoracle-ecdsa-key-file
          secret:
            secretName: your-secrets
            items:
              - key: ecdsa-private-key
                path: ecdsaEncryptedWallet.json
        - name: eoracle-aliased-ecdsa-key-file
          secret:
            secretName: eoracle-ecdsa-key
            items:
              - key: ecdsa-private-key
                path: ecdsaAliasedEncryptedWallet.json
        - name: eoracle-bls-key-file
          secret:
            secretName: eoracle-bls-key
            items:
              - key: bls-private-key
                path: blsEncryptedWallet.json
