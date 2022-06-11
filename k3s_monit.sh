#!/bin/bash

source ./k3s.sh

echo "Install Monitoring - Grafana"
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add rancher http://charts.rancher.io/
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
