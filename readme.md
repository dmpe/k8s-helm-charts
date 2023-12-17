# Demo

Running a demo [k3s kubernetes cluster](https://docs.k3s.io), with exposed Traefik dashboard, and several other applications.

E.g. AWX operator, external (non-buildin) Traefik Helm Chart or rancher-monitoring, with centralized dashboarding. 

## Cluster Access

```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

## Download/Add Helm Charts

```bash

helm pull traefik/traefik --untar --untardir traefik-external
helm pull jetstack/cert-manager --untar
helm repo add awx-operator https://ansible.github.io/awx-operator/
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add rancher http://charts.rancher.io/
```

# Storage

Look in :

```
cd /var/lib/rancher/k3s/storage
```

# Deinstall

```bash
sudo systemctl stop k3s
sudo k3s-killall.sh
sudo k3s-uninstall.sh
```