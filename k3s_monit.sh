#!/bin/bash

source ./k3s.sh

echo "Install Monitoring - Grafana"
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

# helm template grafana grafana/grafana -f grafana/values.yaml
k3s kubectl apply -f grafana/storage.yaml
helm upgrade --create-namespace --install grafana grafana/grafana -f grafana/values.yaml

xdg-open http://grafana.localhost/
