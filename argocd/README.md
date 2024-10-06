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
sudo microk8s kubectl -n cert-manager create secret generic cloudflare-api-token --from-literal=api-token="$TOKEN"

# for arc
kubectl create secret generic github-secret \
   --namespace=argocd \
   --from-literal=github_token="$PAT"
```
