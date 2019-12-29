# install docker
if [ ! -f /usr/bin/docker ]; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
fi

echo "
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
" > /etc/cluster-config.yaml
chmod -R 755 /etc/cluster-config.yaml

groupadd docker
usermod -aG docker ubuntu

curl -Lo ./kind https://github.com/kubernetes-sigs/kind/releases/download/v0.6.1/kind-$(uname)-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind

kind create cluster --name=omnicore --config=/etc/cluster-config.yaml --wait 5m

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

newgrp docker 

mkdir -p /home/ubuntu/.kube
kind get kubeconfig > /home/ubuntu/.kube/config
chmod -R 755 /home/ubuntu/.kube/config

echo "
  kind delete cluster --name=omnicore
  kind create cluster --name=omnicore --config=/etc/cluster-config.yaml --wait 5m
" > /usr/bin/reset-cluster
chmod +x /usr/bin/reset-cluster
