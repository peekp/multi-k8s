
docker build -t patrickpeek/multi-client:latest -t patrickpeek/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t patrickpeek/multi-server:latest -t patrickpeek/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t patrickpeek/multi-worker:latest -t patrickpeek/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push patrickpeek/multi-client:latest
docker push patrickpeek/multi-server:latest
docker push patrickpeek/multi-worker:latest

docker push patrickpeek/multi-client:$SHA
docker push patrickpeek/multi-server:$SHA
docker push patrickpeek/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=patrickpeek/multi-server:$SHA
kubectl set image deployments/client-deployment client=patrickpeek/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=patrickpeek/multi-worker:$SHA