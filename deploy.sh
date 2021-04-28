docker build -t mdechdee/multi-client:latest -t mdechdee/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mdechdee/multi-server:latest -t mdechdee/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mdechdee/multi-worker:latest -t mdechdee/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mdechdee/multi-client:latest
docker push mdechdee/multi-server:latest
docker push mdechdee/multi-worker:latest

docker push mdechdee/multi-client:$SHA
docker push mdechdee/multi-server:$SHA
docker push mdechdee/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mdechdee/multi-server:$SHA
kubectl set image deployments/client-deployment client=mdechdee/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mdechdee/multi-worker:$SHA