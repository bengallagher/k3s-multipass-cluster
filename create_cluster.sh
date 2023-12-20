#!/bin/sh

# Define specific K3S version - comment out to install latest.
# https://github.com/k3s-io/k3s/releases
export K3S_VERSION="v1.23.8+k3s2"

# Load re-usable functions.
for settings in $(find ./src -type f -maxdepth 1 | sort)
do
    source ${settings}
done

# Set manual variables
server_name="k3s-server"
node_name="k3s-node"

# Create master node/server
create_server_init_file
create_server ${server_name}

# Define values to enable nodes to join cluster.
export_k3s_token ${server_name}
export_k3s_url ${server_name}

# Create nodes and auto-join to cluster.
create_node_init_file
create_node ${node_name}-01
create_node ${node_name}-02

# Get config from server and store locally.
export_kube_config ${server_name}