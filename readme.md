# Demo

Running k3s kubernetes cluster, with exposed Traefik dashboard, and several uses cases. 

E.g. AWX operator using its ingress or rancher-monitoring, with centralized dashboarding. 

## Cluster Access

```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

## Helm Charts

```bash

helm pull traefik/traefik --untar --untardir traefik-external
helm pull jetstack/cert-manager --untar
```

# Storage

Look in :

```
cd /var/lib/rancher/k3s/storage
```