#/bin/bash
echo "Deploying ConfigMap with helpers scripts (hooks, probes)..."
kubectl apply -f ../kubernetes/cassandra-configmap.yaml
echo "Deploying Service"
kubectl apply -f ../kubernetes/cassandra-service.yaml
echo "Deploying StatefulSet"
kubectl apply -f ../kubernetes/cassandra-statefulset.yaml

