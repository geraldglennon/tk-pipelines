# tk-pipelines
This is a project to create tekton pipelines 

Below is an example of using kubectl these pipelines can be started.
Each flow allows the user to deploy to the current Kubernetes cluster or to an external cluster.

By leaving cluster_config parameter blank it will use the default. If the user adds the cluster config file data to this param it will be used 
to connect to the cluster specified.

## Example pipeline of helm install or upgrade:

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  name: helm-install-upgrade
spec:
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

## Example pipeline helm uninstall

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  name: helm-uninstall
spec:
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
  name: helm-rollback
spec:
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