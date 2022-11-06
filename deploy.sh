docker build -t shahban/multi-client:latest -t shahban/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shahban/multi-server:latest -t shahban/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t shahban/multi-worker:latest -t shahban/multi-worker:$SHA -f ./client/Dockerfile ./worker

docker push shahban/multi-client:latest
docker push shahban/multi-server:latest
docker push shahban/multi-worker:latest

docker push shahban/multi-client:$SHA
docker push shahban/multi-server:$SHA
docker push shahban/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shahban/multi-server:$SHA
kubectl set image deployments/server-deployment client=shahban/multi-client:$SHA
kubectl set image deployments/server-deployment worker=shahban/multi-worker:$SHA