#! /bin/bash

function create_node_init_file() {
    local init_file="./node.yaml"

    cat > ${init_file} <<EOL
users:
- name: ${USER}
  groups: sudo
  sudo: ALL=(ALL) NOPASSWD:ALL
  ssh_authorized_keys:
    - $(cat "${HOME}/.ssh/id_rsa.pub")
runcmd:
  - sudo apt update
  - sudo apt upgrade -y
  - curl -sfL https://get.k3s.io | K3S_URL="${K3S_URL}" K3S_TOKEN="${K3S_TOKEN}" sh -
EOL
}

function create_server_init_file() {
    local init_file="./server.yaml"

    cat > ${init_file} <<EOL
users:
- name: ${USER}
  groups: sudo
  sudo: ALL=(ALL) NOPASSWD:ALL
  ssh_authorized_keys:
  - $(cat "${HOME}/.ssh/id_ed25519.pub")
runcmd:
  - sudo apt update
  - sudo apt upgrade -y
  - curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="server --disable traefik, servicelb" sh -
EOL
}