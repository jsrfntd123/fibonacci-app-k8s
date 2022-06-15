-KUBERNETES IS A SYSTEM TO DEPLOY CONTAINERAIZED APPS.
-NODES ARE VM OR PHISYCAL SERVERS
-MASTERS ARE MACHINES WITH A SET OF PROGRAMS TO MANAGE NODES
-KUBERNETES DIDNT BUILD OUR IMAGES
-KUBERNETES (MASTER) DECIDES WHERE TO RUN EACH CONTAINER. ECAH NODE CAN RUN A SIMILAR SET OF CONTAINERS
-TO DEPLOY SOMETHING, WE UPDATE THE DESIRED STATE OF THE MASTER WITH A CONFIG FILE
-THE MASTER WORKS CONSTANTLY TO MEET YOUR DESIRED STATE
-YOU CAN CONFIGURE WHERE YOU WANT TO RUN THE PODS (NODES)

## COMMAND TO CREATE KUBERNETES
#Create a pod into the cluster
kubectl apply -f client-pod.yaml

#Create a networking service into the k8s cluster (Types: Nodeports, ClusterIp, etc). 
kubectl apply -f client-node-port.yaml

## COMMAND TO GET PODS
kubectl get pods

## DEPLOYMENTS: DEPLOYMENTS IS A KUBERNETES OBJECT THAT CAN GROUP MANY PODS. IT MONIORS THE STATE OF EACH POD, UPDATING AS NECESSARY. IN PRODUCTIONS ENVIRONMET WE WONT DEAL WITH PODS. WE ONLY WILL DEAL WITH DEPLOYMENTS.

## COMMAND TO GET SERVICES
kubectl get services

## COMMAND TO SEE POD STATUS
kubectl describe pod client-pod

## COMMAND TO DELETE POD
kubectl delete -f client-pod.yaml

## RUN THE DEPLOYMENT FILE
kubectl apply -f client-deployment.yaml

## GET DELOYMENTS
kubectl get deployments

## UPDATE IMAGE VERSION IN DEPLOYMENT
Option 1: Deleting pods manually and re run the deployment.
Option 2: Set an specific version into the deply configuration file
Option 3: Imperative command: kubectl set image deployment/client-deployment client=jsrfntd/multi-client:v6

## MINIKUBE DOCKER ENV: APPLY THE ENVIRONMENT VARIABLES EACH TIME YOU OPEN A NEW TERMINAL
eval $(minikube docker-env)

## SEE LOGS
kubectl logs client-deployment 

## DELETE DEPLOYMENT
kubectl delete  deployment client-deployment

## DELETE SERVICE
kubectl delete  service client-node-port

# CREATE A SECRET IN K8S
# TYPES SECRETS ARE: GENERIC, DOCKER REGISTRY, TLS
kubectl create secret generic pgpassword --from-literal PGPASSWORD=password123


## CREATE INGRESS CONTROLLER
## IT CREATE A DEFAULT BACKEND FOR A HEALTHCHECK

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/cloud/deploy.yaml




