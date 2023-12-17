#!/bin/bash

curl -sfL https://get.k3s.io | sh -

sudo chown $USER:$USER -R /etc/rancher/k3s/
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

echo "Setup k8s dashboard on localhost."
k3s kubectl create -f kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v3.0.0-alpha0/charts/kubernetes-dashboard.yaml

k3s kubectl create -f charts/k3s/dashboard.yaml
k3s kubectl -n kubernetes-dashboard describe secret admin-user-token | grep '^token'
k3s kubectl proxy &
xdg-open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

echo "Setup traefik dashboard on localhost."
kubectl apply -f charts/traefik/traefik.yaml
xdg-open http://traefik.localhost/dashboard/

echo "Apply storage class for local host"
kubectl apply -f sc.yaml
