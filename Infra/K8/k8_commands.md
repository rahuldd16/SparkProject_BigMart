
### start minikube cluster locally
```shell
minikube start
```

### Create namespace
```shell
kubectl create namespace spark

```
### Install crds required for spark operartor
_what are crds?_

CRDs are like templates that define new resource types in Kubernetes. They allow you to create, configure, and manage custom resources, expanding the capabilities of your Kubernetes cluster beyond the built-in resource types such as Pods, Services, and Deployments.

_How CRDs Work?_

CRDs work by defining a new API endpoint within the Kubernetes API server. When you create a CRD, Kubernetes creates a new RESTful API endpoint that can be used to create, read, update, and delete custom resources of that type.

```shell
helm repo add spark-operator https://kubeflow.github.io/spark-operator

helm repo update
```
cmd >>  `helm install [RELEASE_NAME] spark-operator/spark-operator`
```shell
helm install spark-operator spark-operator/spark-operator \
    --namespace spark-operator \
    --create-namespace
```