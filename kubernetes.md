## Kubernetes HomeLab

**Setting:** 3 VMs (a cluster with 1 master node + 2 worker node)   
**OS:** Ubuntu server LTS 24.04.3  
**Hypervisor:** VMware workstation


### <span style="color:red">1. Download necessary tools</span>

#### 1.1. Update package manager and HTTPS set up

<pre>
sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl
</pre>

- `-y` = yes to all prompt
- `apt-transport-https` allows APT to download packages over HTTPS.
- `ca-certificates` verify TLS of the other ends.
- `curl` fetch/send data over the internet.

#### 1.2. Disable swap

swap = disk space used as extra RAM when real RAM is full.

Kubernetes wants real, predictable RAM, not disk-based memory.

<pre>
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
</pre>

See: 
- [Swap Off - why is it necessary?](https://discuss.kubernetes.io/t/swap-off-why-is-it-necessary/6879)
- [Kubelet/Kubernetes should work with Swap Enabled](https://github.com/kubernetes/kubernetes/issues/53533)

#### 1.3. Networking Configuration

*To be honest, this part I still didn't get that 100%.
But we have to run below snippet.

<pre>
cat &lt;&lt;EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat &lt;&lt;EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
</pre>

- `/etc/modules-load.d/k8s.conf` This file tells Linux which kernel modules to load automatically at boot.

- `overlay` Enables the overlay filesystem, which is essential for container runtimes (like containerd or Docker). Containers often use overlayfs to stack layers of images efficiently.

- `br_netfilter` Allows Linux bridges (used in Kubernetes networking) to pass traffic through iptables for filtering and NAT. Without this, Kubernetes services and pods may not be able to communicate properly across nodes.

- `modprobe` Loads a kernel module right now without rebooting.

This creates a file in /etc/sysctl.d/ which sets persistent kernel parameters (applied at boot).

net.bridge.bridge-nf-call-iptables = 1
Makes sure that traffic across Linux bridges (used by CNI plugins like Flannel, Calico, etc.) is visible to iptables. This lets Kubernetes enforce network policies and NAT.

net.bridge.bridge-nf-call-ip6tables = 1
Same as above but for IPv6 traffic.

net.ipv4.ip_forward = 1
Enables packet forwarding between network interfaces. Without this, your node would not route packets from pods to other pods/services or to the outside world.

- `sysctl` applies changes to the kernel parameters immediately.

- `--system` = reload all config files.

#### 1.4. Install & configure containerd


#### 1.5. Install kubeadm, kubelet, kubectl

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

ptionally enable kubelet (it will sit waiting until kubeadm configures it)
sudo systemctl enable --now kubelet

#### 1.6.  (on master node)

<pre>
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --upload-certs

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
</pre>

then check if node ready

<pre>kubectl get nodes</pre>

After that download CNI plugins

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

or 

kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

then if status = Ready paste the  
kubeadm join <master-ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
that get from output of kubeadm init on workernode to join.

then check 

kubectl get nodes

Done! Now my cluster is ready.

#### 1.7. (optional) Download Git

<pre>sudo apt install git -y</pre>

I use git to download manifest files (by cloning this repo) to do lab. 

### <span style="color:red">2. Labs</span>

#### Lab 2.1.  