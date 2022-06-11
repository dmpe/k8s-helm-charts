#!/bin/bash

echo "Install AWX"
helm repo add awx-operator https://ansible.github.io/awx-operator/
helm install my-awx-operator awx-operator/awx-operator
# kubectl get secret awx-demo-admin-password -o jsonpath="{.data.password}" | base64 --decode
kubectl apply -f awx/awx.yaml

xdg-open http://awx-demo.localhost/
