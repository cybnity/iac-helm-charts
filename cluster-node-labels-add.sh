#! /bin/bash

# BE CAREFULL, MINIKUBE LOST LABELS ON NODES WHEN RESTARTED
echo "Add labels to the cluster nodes"

kubectl label nodes local layer=user-interfaces-area
kubectl label nodes local-m02 layer=domains-io-area
kubectl label nodes local-m03 layer=domains-area
kubectl label nodes local-m04 layer=infrastructure-services-area

kubectl get nodes --show-labels
