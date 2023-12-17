#!/bin/bash

source ./k3s.sh

echo "Install Monitoring - Grafana"
helm repo update

# helm pull rancher/rancher-monitoring-crd --untar --untardir .
# helm pull rancher/rancher-monitoring --untar --untardir .
# helm pull grafana/grafana --untar --untardir .

# helm template grafana ./charts/grafana -f ./charts/grafana/values.yaml -f ./charts/grafana/MY_values.yaml
helm upgrade --create-namespace --install grafana ./charts/grafana \
    -f ./charts/grafana/values.yaml -f ./charts/grafana/MY_values.yaml

helm upgrade --create-namespace --install rancher-monitoring-crd ./charts/rancher-monitoring-crd \
    -f ./charts/rancher-monitoring-crd/values.yaml

helm upgrade --create-namespace --install rancher-monitoring ./charts/rancher-monitoring \
    -f ./charts/rancher-monitoring/values.yaml -f ./charts/rancher-monitoring/MY_values.yaml

xdg-open http://grafana.localhost/

# https://gist.github.com/jannegpriv/06427e4ecc2a17f317a4bebc32b6445c
echo "Setup k8s dashboard on localhost."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v3.0.0-alpha0/charts/kubernetes-dashboard.yaml
 
kubectl create -f charts/k8s/dashboard.yaml
# https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md#getting-a-bearer-token-for-serviceaccount
kubectl -n kubernetes-dashboard create token admin-user

xdg-open https://k8s.localhost
