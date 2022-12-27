# tk-pipelines
This is a project to that contains Tekton pipelines to install/uninstall rollback applications
It uses helm, kubectl or helmfile tools to perform these tasks

Below is an example of using kubectl to start Tekton pipelines.
Each pipeline allows the user to deploy to the current Kubernetes cluster or to an external cluster.

By leaving cluster_config parameter blank it will use the current cluster Tekton is deployed towards. If the user adds the cluster config file data to this param it will be used 
to connect to the cluster specified. This file contains the kube config to connect to the cluster to install onto.

## Example pipeline of helm install or upgrade:

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  generateName: helm-install-upgrade-
spec:
  serviceAccountName: tk-pipelines
  pipelineRef:
    name: helm-deploy-pipeline
  params:
    - name: url
      value: https://somewhere/helm/chart.tgz
    - name: cluster_config
      value: ""
    - name: name
      value: test-deploy
    - name: namespace
      value: default
    - name: timeout
      value: 400s
    - name: values
      value: ""
``` 

## Example pipeline of helm install or upgrade using secure url:

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  generateName: helm-install-app-
spec:
  serviceAccountName: tk-pipelines
  pipelineRef:
    name: helm-deploy-https
  params:
    - name: url
      value: https://somewhere/helm/chart.tgz
    - name: cluster_config
      value: ""
    - name: name
      value: test-deploy
    - name: namespace
      value: default
    - name: timeout
      value: 400s
    - name: values
      value: ""
    - name: cert_secret_name
      value: app-tls-secret
    - name: cert_pem
      value: | 
        <certificate chain>
    - name: cert_key
      value: |
        <certificate key> 
    - name: docker_config_command
      value: create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<user-name> --docker-password=<password>
``` 

## Example pipeline helm uninstall

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  generateName: helm-uninstall-
spec:
  serviceAccountName: tk-pipelines
  pipelineRef:
    name: helm-uninstall-pipeline
  params:
    - name: cluster_config
      value: ""
    - name: name
      value: test-deploy
    - name: namespace
      value: default
``` 

## Example pipeline helm rollback

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  generateName: helm-rollback-
spec:
  serviceAccountName: tk-pipelines
  pipelineRef:
    name: helm-rollback-pipeline
  params:
    - name: cluster_config
      value: ""
    - name: name
      value: test-deploy
    - name: namespace
      value: default
```

## Example pipeline of helmfile deploy using secure url:

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  generateName: helmfile-deploy-apps-
spec:
  serviceAccountName: tk-pipelines
  pipelineRef:
    name: helmfile-deploy-https
  workspaces:
    - name: helmfile-ws1
      volumeClaimTemplate:
        spec:
          accessModes:
            - ReadWriteOnce
          resources:
            requests:
              storage: 1Gi
  params:
    - name: url
      value: https://somewhere/helmfile/chart.tgz
    - name: cluster_config
      value: ""
    - name: namespace
      value: default
    - name: values
      value: ""
    - name: cert_secret_name
      value: app-tls-secret
    - name: cert_pem
      value: | 
        <certificate chain>
    - name: cert_key
      value: |
        <certificate key> 
    - name: docker_config_command
      value: create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<user-name> --docker-password=<password>
    - name: username
      value: fake_user
    - name: password
      value: fake_password
```