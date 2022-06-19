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


##  DEPLOYMENT IN PRODUCTION

# CONCEPTS: 
#   - HELM: IT IS A PROGRAM THAT WE CAN USE TO ADMINISTER THIRD PARTY SOFTWARE INSIDE K8S CLUSTERS.
#           iT IS COMPOSE BY HELM CLEINT AND TILLER SERVER. TILLER SERVER IS RUNNING IN THE CLUSTER AND
#           IS REPONSIBLE FOR MODIFYNG THE CLUSTER AND INSTALL ADITIONAL OBJECT INSIDE IT. TILLER IS A 
#           POD INTO THE CLUSTER THAT ATTEMP TO MAKE CHANGES TO THE CONFIGURATION OF THE CLUSTER 
#           (NEW SETS OF SECRETS, NEW SETS OF CONFIGURATION, NEW SETS OF DEPLOYMENTS )
#           COMMANDS TO INSTALL HELM (execute this commands in GCP console):
#           -curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
#           -chmod 700 get_helm.sh
#           -./get_helm.sh
#   - RBAC (ROLE BASED ACCESS CONTROL):
#       - LIMIT WHO CAN ACCES AND MODIFY OBJECTS IN OUR CLUSTER
#       - ENABLED ON GOOGLE CLOUD BY DEFAULT
#       - TILLER WANTS TO MAKE CHANGES TO OUR CLUSTER, SO IT NEEDS TO GET SOME PERMISSIONS SET
#       - GCP KEY CONCEPTS: 
#           - USER ACCOUNTS: IDENTIFIES A PERSON ADMINISTERING OUR CLUSTER
#           - SERVICE ACCOUNTS: IDENTIFIES A POD ADMINISTERING THE CLUSTER
#           - CLUSTER ROLE BINDING: AUTHORIZES AN ACCOUNT TO DO A CERTAIN SET OF ACTIONS ACROSS THE ENTIRE CLUSTER
#           - ROLE BINDING: AUTHORIZES AN ACCOUNT TO DO A CERTAIN SET OF ACTIONS IN A *SINGLE NAMESPACE*

#           CREATE A NEW SERVICE ACCOUNT CALLED TILLER IN THE KUBE-SYSTEM NAMESPACE:
#               - kubectl create serviceaccount --namespace kube-system tiller

#           CREATE A NEW CLUSTERROLEBINDING WITH THE ROLE 'CLUSTER-ADMIN' AND ASSIGN IT TO SERVICE ACCOUNT 'TILLER'
#               - kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# INSTALL HELM IN THE K8S CLUSTER:
#   - helm init --service-account tiller --upgrade

# Install Ingress-Nginx: In your Google Cloud Console run the following:
#   - helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
#   - helm install my-release ingress-nginx/ingress-nginx

# In gcp console it will create an ingress controller deployment that manages the pod that runs the controller thet is going to read the ingress config file and aditionaly it will create a GCP load balancer to distribute the load into the diferents nodes in the cluster. The flow is: GCP load balancer -> NGINX Ingress controller -> Diffrent app deployments






