#!/bin/bash

echo "Installing tekton core"
echo 
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.70.0/release.yaml

echo 
echo "Installing tekton triggers"
echo 
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.31.0/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.31.0/interceptors.yaml

echo 
echo "Installing tekton dasboard"
echo 
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/previous/v0.56.0/release-full.yaml -n tekton-pipelines

echo
echo "Installing tekton ingres"
kubectl apply -f tekton-ingress.yaml -n tekton-pipelines