#!/bin/bash

set -e

source .env

kubectl create secret generic postgres-postgresql \
  --namespace database \
  --from-literal=postgres-password="$DB_PASSWORD \
  --dry-run=client \
  -o yaml \
| kubeseal \
    --controller-name sealed-secrets-controller \
    --controller-namespace sealed-secrets \
    --format yaml \
    > applications/secret/postgres-sealed-secret.yaml

echo "Generated DB sealed secret"

kubectl create secret generic minio \
  --namespace minio \
  --from-literal=root-user="$MINIO_ROOT_USER" \
  --from-literal=root-password="$MINIO_ROOT_PASSWORD" \
  --dry-run=client \
  -o yaml \
| kubeseal \
    --controller-name sealed-secrets-controller \
    --controller-namespace sealed-secrets \
    --format yaml \
    > applications/secret/minio-sealed-secret.yaml

echo "Generated MINIO sealed secret"