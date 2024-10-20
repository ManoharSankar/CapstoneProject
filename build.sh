#!/bin/bash

IMAGE_NAME="capstoneproject_guvi"
IMAGE_TAG="latest"
DEV_REPO="manoharms/reactapp-dev"
PROD_REPO="manoharms/reactapp-prod"
BRANCH=$(git rev-parse --abbrev-ref HEAD)
COMPOSE_FILE="docker-compose.yml"


#Remove the previous image
docker rmi -f $IMAGE_NAME:$IMAGE_TAG
# Build Docker image
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Push to Docker Hub based on the current branch
if [ "$BRANCH" == "dev" ]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $DEV_REPO:$IMAGE_TAG
    echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
    docker push $DEV_REPO:$IMAGE_TAG
elif [ "$BRANCH" == "main" ]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $PROD_REPO:$IMAGE_TAG
    echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
    docker push $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch. Image won't be pushed."
fi

