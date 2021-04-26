docker build -t benjamincusto/multi-client:latest -t benjamincusto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t benjamincusto/multi-server:latest -t benjamincusto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t benjamincusto/multi-worker:latest -t benjamincusto/multi-worker:$SHA -f ./client/Dockerfile ./worker
docker push benjamincusto/multi-client:latest
docker push benjamincusto/multi-server:latest
docker push benjamincusto/multi-worker:latest

docker push benjamincusto/multi-client:$SHA
docker push benjamincusto/multi-server:$SHA
docker push benjamincusto/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=benjamincusto/multi-server:$SHA
kubectl set image deployments/client-deployment server=benjamincusto/multi-client:$SHA
kubectl set image deployments/worker-deployment server=benjamincusto/worker-client:$SHA

