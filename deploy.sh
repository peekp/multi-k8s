
docker build -t peekp/multi-client:latest -t peekp/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t peekp/multi-server:latest -t peekp/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t peekp/multi-worker:latest -t peekp/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push peekp/multi-client:latest
docker push peekp/multi-server:latest
docker push peekp/multi-worker:latest

docker push peekp/multi-client:$SHA
docker push peekp/multi-server:$SHA
docker push peekp/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=peekp/multi-server:$SHA
kubectl set image deployments/client-deployment client=peekp/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=peekp/multi-worker:$SHA