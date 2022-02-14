1. Add jenkins helm repo
```sh
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
```
2. Create namespace jenkins
```sh
kubectl create ns jenkins
```
3. Create a service account
```sh
kubectl apply -f jenkins-ci/jenkins-sa.yaml
```
4. Install jenkins
```sh
helm upgrade --cleanup-on-fail \
--install jenkins jenkinsci/jenkins \
--values jenkins-ci/jenkins.values.yaml \
--namespace jenkins \
--create-namespace
```

5. Get your 'admin' user password by running:
```sh
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
```
