#!/bin/bash

source ./k3s.sh

echo "Install Monitoring - Grafana"
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm template grafana grafana/grafana -f grafana/values.yaml
helm upgrade --create-namespace --install abc grafana/grafana -f grafana/values.yaml

xdg-open http://grafana.localhost/
