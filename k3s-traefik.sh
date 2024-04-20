#!/bin/bash

echo "Setup traefik dashboard on localhost."

helm upgrade --install --create-namespace -n traefik traefik ./charts/traefik-external/traefik

# for azure where it needs to run with integrated traefik on k3s
kubectl apply -f charts/traefik-internal/traefik-config.yaml

kubectl apply -f charts/traefik-internal/dashboard.yaml
xdg-open http://traefik.localhost:9000/dashboard

