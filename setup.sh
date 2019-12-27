# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

echo "
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
" > cluster-config.yaml

kind create cluster --config=cluster-config.yaml --quiet
