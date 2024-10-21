#!/bin/bash
set -x
IMAGE_TAG="latest"
DEV_REPO="manoharms/guviapp-dev"
PROD_REPO="manoharms/guviapp-prod"
CONTAINER_NAME="guvi-app-container"
COMPOSE_FILE="docker-compose.yml"
BRANCH_NAME="$1"
echo "$BRANCH_NAME"
BRANCH_NAME="${BRANCH_NAME#origin/}"


#Running the containers
#docker-compose -f $COMPOSE_FILE up

# Pull and run the correct Docker image
if [[ "$BRANCH_NAME" == "dev" && "$DEV_REPO" == "manoharms/guviapp-dev" ]]; then
    docker pull $DEV_REPO:$IMAGE_TAG
    #docker run -d -p 80:80 --name $CONTAINER_NAME $DEV_REPO:$IMAGE_TAG
    docker-compose -f $COMPOSE_FILE up -d

elif [[ "$BRANCH_NAME" == "main" && "$PROD_REPO" == "manoharms/guviapp-prod" ]]; then
    docker pull $PROD_REPO:$IMAGE_TAG
    #docker run -d -p 80:80 --name $CONTAINER_NAME $PROD_REPO:$IMAGE_TAG
    # Stop and remove existing container
    docker stop $CONTAINER_NAME || true
    docker rm $CONTAINER_NAME || true
    docker-compose -f $COMPOSE_FILE up -d
else
    echo "No valid branch for deployment."
fi

