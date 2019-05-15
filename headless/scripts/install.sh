#!/usr/bin/env bash

cd $HOME/headless/
kubectl create namespace hs && kubectl label namespace hs istio-injection=enabled --overwrite
helm install . --namespace hs