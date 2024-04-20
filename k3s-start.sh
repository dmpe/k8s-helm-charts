#!/bin/bash

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-backend=none --disable-network-policy --disable=servicelb --disable=traefik" sh -
sudo kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.3/manifests/tigera-operator.yaml
sudo kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml create -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.3/manifests/custom-resources.yaml

sudo chown $USER:$USER -R /etc/rancher/k3s/
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

kubectl get all -A
kubectl get node  -o wide

helm upgrade --create-namespace --install cert-manager ./charts/cert-manager/
