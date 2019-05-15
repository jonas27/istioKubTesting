#!/usr/bin/env bash
tee deletePods.sh &>/dev/null << EOF
export N="understood-zebra"
kubectl delete pod -n vps $N-manager-replicaset-fk9lj
kubectl delete pod -n vps $N-monitor-replicaset-gq9nm
kubectl delete pod -n vps $N-node-daemonset-8dp9t
kubectl delete pod -n vps $N-node-daemonset-95js2
kubectl delete pod -n vps $N-proxy-replicaset-md2c2
EOF
