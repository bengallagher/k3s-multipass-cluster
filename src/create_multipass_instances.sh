#! /bin/bash

function create_server() {
    local random=$(uuidgen | sed "s/[-]//g" | head -c 5)
    local name="${1:-k3s-server-${random}}"
    local cpus="${2:-1}"
    local memory="${3:-1G}"
    local disk="${5:-5G}"

    multipass launch --verbose \
        --name "${name}" \
        --cpus "${cpus}" \
        --memory "${memory}" \
        --disk "${disk}" \
        --timeout 120 \
        --cloud-init "${K3S_INIT_SERVER}"
}

function create_node() {
    local random=$(uuidgen | sed "s/[-]//g" | head -c 5)
    local name="${1:-k3s-node-${random}}"
    local cpus="${2:-1}"
    local memory="${3:-1G}"
    local disk="${5:-5G}"

    multipass launch --verbose \
        --name "${name}" \
        --cpus "${cpus}" \
        --memory "${memory}" \
        --disk "${disk}" \
        --timeout 120 \
        --cloud-init "${K3S_INIT_NODE}"
}
