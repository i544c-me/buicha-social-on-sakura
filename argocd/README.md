# argocd

```bash
argocd app create main \
  --repo https://github.com/i544c-me/buicha-social-on-sakura.git --path argocd \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace default \
  --sync-policy automated
```

```bash
# for cert-manager
sudo microk8s kubectl create secret generic cloudflare-api-token \
  --namespace=cert-manager \
  --from-literal=api-token="$TOKEN"

# for arc
sudo microk8s kubectl create secret generic github-secret \
   --namespace=argocd \
   --from-literal=github_token="$PAT"

# for forgejo
sudo microk8s kubectl create secret generic forgejo-admin-secret \
   --namespace=argocd \
   --from-literal=username=i544c \
   --from-literal=password="$PASSWORD" \
   --from-literal=email="$EMAIL"

sudo microk8s kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: forgejo-additional-secret
  namespace: argocd
stringData:
  storage: |
    MINIO_USE_SSL=true
    MINIO_ENDPOINT=$ID.r2.cloudflarestorage.com:443
    MINIO_ACCESS_KEY_ID=$KEY
    MINIO_SECRET_ACCESS_KEY=$SECRET
    MINIO_BUCKET=$BUCKET
    MINIO_LOCATION=apac
    MINIO_CHECKSUM_ALGORITHM=md5
EOF

# for discord bot
sudo microk8s kubectl create secret generic discord-bot-sabakan \
   --namespace=argocd \
   --from-literal=APP_ID=$APP_ID \
   --from-literal=PUBLIC_KEY=$PUBLIC_KEY \
   --from-literal=DISCORD_TOKEN=$DISCORD_TOKEN

# for sacloud
sudo microk8s kubectl create secret generic discord-bot-sabakan-sacloud \
   --namespace=argocd \
   --from-literal=SAKURACLOUD_ACCESS_TOKEN=$TOKEN \
   --from-literal=SAKURACLOUD_ACCESS_TOKEN_SECRET=$SECRET \
   --from-literal=SAKURACLOUD_ZONE=is1a
```
