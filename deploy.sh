#!/bin/bash
set -x
IMAGE_NAME="capstoneproject_guvi"
IMAGE_TAG="latest"
DEV_REPO="manoharms/reactapp-dev"
PROD_REPO="manoharms/reactapp-prod"
CONTAINER_NAME="guvi-app-container"
COMPOSE_FILE="docker-compose.yml"
BRANCH_NAME="$1"
echo "$BRANCH_NAME"
BRANCH_NAME="${BRANCH_NAME#origin/}"
# Stop and remove existing container
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

#Running the containers
#docker-compose -f $COMPOSE_FILE up

# Pull and run the correct Docker image
if [ "$BRANCH_NAME" == "dev" ]; then
    docker pull $DEV_REPO:$IMAGE_TAG
    docker run -d -p 80:80 --name $CONTAINER_NAME $DEV_REPO:$IMAGE_TAG
elif [ "$BRANCH_NAME" == "main" ]; then
    docker pull $PROD_REPO:$IMAGE_TAG
    docker run -d -p 80:80 --name $CONTAINER_NAME $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch for deployment."
fi

