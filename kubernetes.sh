#!/bin/bash


cleanup() {
    echo "Capturado CTRL+C, limpando recursos..."

    if [[ -n $KUBETAIL_PID ]]; then
        kill -SIGINT $KUBETAIL_PID
    fi

    kubectl delete deployment postgres-deployment
    kubectl delete service postgres-service

    kubectl delete deployment redis-deployment
    kubectl delete service redis-service

    kubectl delete deployment server-deployment
    kubectl delete service server-service
    kubectl delete hpa server-hpa

    kubectl delete deployment ws-deployment
    kubectl delete service ws-service
    kubectl delete hpa ws-hpa
    
    echo -e "${Green}Done. O Volume do Postgres não será deletado."
    exit
}

trap cleanup SIGINT

set -e

# Cores de texto
Default='\033[0m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'


echo
echo -e "${Cyan} # ANTES DE RODAR ESSE SCRIPT, CERTIFIQUE-SE:"
echo -e "${Red}   - Docker está instalado e rodando"
echo -e "   - kubectl está instalado" 
echo -e "   - Minikube está instalado e rodando (inicie com 'minikube start --driver=docker' e confira com 'minikube status') "
echo -e "   - >5GB livres ${Default}" 
echo 

sleep 2

echo "Configurando Docker para usar o daemon do Minikube..."
eval $(minikube docker-env)

echo "ativando métricas do Minikube..."
minikube addons enable metrics-server

echo "Aplicando Deployment do Postgres no Kubernetes..."
kubectl apply -f ./kubernetes/postgres-deployment.yaml

echo "Aplicando Service do Postgres no Kubernetes..."
kubectl apply -f ./kubernetes/postgres-service.yaml

echo "Aplicando Volume do Postgres no Kubernetes..."
kubectl apply -f ./kubernetes/postgres-pv.yaml

echo "Aplicando Deployment do Redis no Kubernetes..."
kubectl apply -f ./kubernetes/redis-deployment.yaml

echo "Aplicando Service do Redis no Kubernetes..."
kubectl apply -f ./kubernetes/redis-service.yaml

echo "Construindo a imagem Docker para o servidor Go..."
docker build -t server -f server/prod.Dockerfile server/

echo "Aplicando Deployment do server no Kubernetes..."
kubectl apply -f ./kubernetes/server-deployment.yaml

echo "Aplicando Service do server no Kubernetes..."
kubectl apply -f ./kubernetes/server-service.yaml

echo "Aplicando Scaler do Server..."
kubectl apply -f ./kubernetes/server-hpa.yaml

echo "Construindo a imagem Docker para o servidor WS..."
docker build -t ws-server -f ws-server/prod.Dockerfile ws-server/

echo "Aplicando Deployment do WS no Kubernetes..."
kubectl apply -f ./kubernetes/ws-deployment.yaml

echo "Aplicando Service do WS no Kubernetes..."
kubectl apply -f ./kubernetes/ws-service.yaml

echo "Aplicando Scaler do WS..."
kubectl apply -f ./kubernetes/ws-hpa.yaml

echo "O IP do Minikube é:"
minikube ip

echo
echo -e "${Green}---------"
echo
echo "Você pode abrir a dashboard do Kubernetes com o comando:"
echo -e "-> ${Cyan}minikube dashboard${Green}"
echo
echo "O servidor está disponível em:"
echo -e "-> ${Cyan}http://$(minikube ip):30000${Green}"
echo
echo "Pressione CTRL+C para parar e limpar os recursos."
echo
echo -e "${Purple}O terminal continuará aberto com os logs do servidor:"
echo
echo -e "${Green}---------${Default}"
echo
sleep 5

chmod +x ./kubernetes/kubetail.sh
./kubernetes/kubetail.sh server-deployment,ws-deployment -k pod -z 1 &
KUBETAIL_PID=$!

wait $KUBETAIL_PID

cleanup