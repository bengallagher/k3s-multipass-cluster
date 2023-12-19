# k3s-multipass-cluster

A simple multi-node kubernetes cluster can be achieved using Multipass and K3S.

Once multipass is installed (see [multipass.md](multipass.md)), run the following command to build your cluster.

```bash
$ bash create_cluster.sh
```

Once complete, a `kube_config` file will be copied/updated to your `~/.kube` folder.