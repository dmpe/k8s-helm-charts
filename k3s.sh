#!/bin/bash

curl -sfL https://get.k3s.io | sh -

sudo chown $USER:$USER -R /etc/rancher/k3s/
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

GITHUB_URL=https://github.com/kubernetes/dashboard/releases
VERSION_KUBE_DASHBOARD=$(curl -w '%{url_effective}' -I -L -s -S ${GITHUB_URL}/latest -o /dev/null | sed -e 's|.*/||')
k3s kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/${VERSION_KUBE_DASHBOARD}/aio/deploy/recommended.yaml

k3s kubectl create -f dashboard.yaml
k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
k3s kubectl proxy &
xdg-open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

echo "Setup traefik dashboard on localhost."

xdg-open http://traefik.localhost/dashboard/

echo "Install AWX"

helm install my-awx-operator awx-operator/awx-operator
# kubectl get secret awx-demo-admin-password -o jsonpath="{.data.password}" | base64 --decode
kubectl apply -f awx.yaml

xdg-open http://awx-demo.localhost/
