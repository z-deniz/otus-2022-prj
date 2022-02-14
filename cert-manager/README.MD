1. Add the Jetstack Helm repository
```sh
helm repo add jetstack https://charts.jetstack.io
```
2. Update your local Helm chart repository cache
```sh
helm repo update
```
3. Install cert-manager with crd
```sh
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.7.1 \
  --set installCRDs=true
```
4. Set up a ClusterIssuer
```sh
kubectl apply -f cert-manager/acme-issuer.yaml
```
