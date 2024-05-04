#!/bin/bash


cleanup() {
    echo "Capturado CTRL+C, limpando recursos..."
    kubectl delete deployment server-deployment
    kubectl delete service server-service
    kubectl delete hpa server-hpa
    echo "Done."
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
echo -e "   - Minikube está instalado e rodando (confira com 'minikube status') ${Default}"
echo 

sleep 2

echo "Configurando Docker para usar o daemon do Minikube..."
eval $(minikube docker-env)

echo "ativando métricas do Minikube..."
minikube addons enable metrics-server

echo "Construindo a imagem Docker para o servidor Go..."
docker build -t server -f server/prod.Dockerfile server/

echo "Aplicando Deployment no Kubernetes..."
kubectl apply -f ./kubernetes/server-deployment.yaml

echo "Aplicando Service no Kubernetes..."
kubectl apply -f ./kubernetes/server-service.yaml

echo "Aplicando Scaler do Server..."
kubectl apply -f ./kubernetes/server-hpa.yaml

echo "O IP do Minikube é:"
minikube ip

echo
echo "---------"
echo
echo "Você pode abrir a dashboard do Kubernetes com o comando:"
echo "-> minikube dashboard"
echo
echo "O servidor está disponível em:"
echo "-> http://$(minikube ip):30000"
echo
echo "Pressione CTRL+C para parar e limpar os recursos."
echo
echo "---------"
echo

while true; do
    sleep 1
done