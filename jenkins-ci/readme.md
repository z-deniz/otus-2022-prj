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
