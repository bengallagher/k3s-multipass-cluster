#! /bin/bash

function export_k3s_token() {
    local instance="$1"

    # Get cluster Token from server.
    token="$(multipass exec ${instance} -- \
        /bin/bash -c "sudo cat /var/lib/rancher/k3s/server/node-token")"

    # Export value for re-use.
    export K3S_TOKEN="${token}"

    echo "# Exporting K3S Token [${token}]"
}

function export_k3s_url() {
    local instance="$1"

    # Get IP of cluster server.
    ip=$(multipass info ${instance} | grep "IPv4" | awk -F' ' '{print $2}')

    # Create URL to server.
    url="https://${ip}:6443"

    # Export values for re-use.
    export K3S_IP="${ip}"
    export K3S_URL="${url}"

    echo "# Exporting K3S Server IP + URL [${url}]"
}

function export_kube_config() {
    local instance="$1"

    # Set paths to config files.
    local kube_config_remote="/etc/rancher/k3s/k3s.yaml"
    local kube_config_local="${HOME}/.kube/k3s"

    # Override local path if kube switch installed.
    if [ -d "${HOME}/.kube/kubeconfigs" ]; then
        kube_config_local="${HOME}/.kube/kubeconfigs/k3s"
    fi

    # Copy config from cluster server.
    multipass copy-files ${instance}:${kube_config_remote} ${kube_config_local}

    # Replace home IP with 'actual' of cluster server.
    sed -i '.bak' -e "s#127.0.0.1#${K3S_IP}#g" -- ${kube_config_local}

    # Check it all works by listing the nodes.
    kubectl --kubeconfig=${kube_config_local} get nodes

    # Remove the in-place backup (it's messy).
    if [ -f "${kube_config_local}.bak" ]; then
        rm "${kube_config_local}.bak"
    fi
}