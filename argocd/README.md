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
```
