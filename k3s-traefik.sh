#!/bin/bash

echo "Setup traefik dashboard on localhost."

helm upgrade --install --create-namespace -n traefik traefik ./charts/traefik-external/traefik

kubectl apply -f charts/traefik-internal/dashboard.yaml
xdg-open http://traefik.localhost:9000/dashboard

