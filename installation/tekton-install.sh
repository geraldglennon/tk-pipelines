#!/bin/sh

echo "Installing tekton"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml

echo
echo "Installing tekton triggers"
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/previous/v0.24.1/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/previous/v0.24.1/interceptors.yaml

echo
echo "Installing tekton dasboard"
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml -n tekton-pipelines

echo
echo "Installing tekton ingres"
kubectl apply -f tekton-ingress.yaml -n tekton-pipelines