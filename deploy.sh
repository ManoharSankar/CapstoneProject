#!/bin/bash

IMAGE_NAME="man"
IMAGE_TAG="latest"
DEV_REPO="manoharms/reactapp-dev"
PROD_REPO="manoharms/reactapp-prod"
CONTAINER_NAME="guvi-app-container"
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Stop and remove existing container
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Pull and run the correct Docker image
if [ "$BRANCH" == "dev" ]; then
    docker pull $DEV_REPO:$IMAGE_TAG
    docker run -d -p 80:80 --name $CONTAINER_NAME $DEV_REPO:$IMAGE_TAG
elif [ "$BRANCH" == "main" ]; then
    docker pull $PROD_REPO:$IMAGE_TAG
    docker run -d -p 80:80 --name $CONTAINER_NAME $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch for deployment."
fi

