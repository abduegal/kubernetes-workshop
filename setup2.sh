apt-get update && apt-get install curl

DOCKERVERSION=18.03.1-ce
curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz \
  && tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 \
                 -C /usr/local/bin docker/docker \
  && rm docker-${DOCKERVERSION}.tgz
  

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
kind get kubeconfig --name=omnicore > /home/ubuntu/.kube/config 
chmod -R 755 /home/ubuntu/.kube/config
