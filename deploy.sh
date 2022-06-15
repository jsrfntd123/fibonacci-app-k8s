docker build -t jsrfntd/multi-client:latest -t jsrfntd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jsrfntd/multi-server:latest -t jsrfntd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jsrfntd/multi-worker:latest -t jsrfntd/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push jsrfntd/multi-worker:latest
docker push jsrfntd/multi-server:latest
docker push jsrfntd/multi-worker:latest

docker push jsrfntd/multi-worker:$SHA
docker push jsrfntd/multi-server:$SHA
docker push jsrfntd/multi-worker:$SHA

kubectl apply -f k8s

#set the image to a specific deployment
kubectl set image deployments/client-deployment server=jsrfntd/multi-client:$SHA
kubectl set image deployments/server-deployment server=jsrfntd/multi-server:$SHA
kubectl set image deployments/worker-deployment server=jsrfntd/multi-worker:$SHA

#In GCP console you have to create the secrets: 
# gcloud auth activate-service-account --key-file service-account.json
# gcloud config set project k8s-project-349216
# gcloud config set compute/zone us-central1-a
# kubectl create secret generic pgpassword --from-literal PGPASSWORD=postgres



