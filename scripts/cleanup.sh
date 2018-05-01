grace=$(kubectl get po cassandra-0 -o=jsonpath='{.spec.terminationGracePeriodSeconds}') \
  && kubectl delete statefulset -l app=cassandra && kubectl delete statefulset -l app=cassandra2 
  #&& echo "Sleeping $grace" \
  #&& sleep $grace 

# Depending on the storage class and reclaim policy,
# deleting the Persistent Volume Claims may cause the associated volumes to also be deleted
kubectl delete pvc -l app=cassandra
kubectl delete pvc -l app=cassandra2

# delete cassandra service
kubectl delete service -l app=cassandra
kubectl delete service -l app=cassandra2
