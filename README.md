# tk-pipelines
This is a project to create tekton pipelines 

```
apiVersion: tekton.dev/v1beta1
kind: PipelineRun
metadata:
  name: deploy-pipeline
spec:
  pipelineRef:
    name: pipeline-with-parameters
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