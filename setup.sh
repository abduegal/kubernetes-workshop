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

sudo groupadd docker
sudo usermod -aG docker $USER

curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.6.1/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind

kind create cluster --config=cluster-config.yaml --quiet

newgrp docker 
