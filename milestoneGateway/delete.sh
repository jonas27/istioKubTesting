#!/usr/bin/env bash
kubectl delete -f gateway.yaml
kubectl delete -f virtual*.yaml
