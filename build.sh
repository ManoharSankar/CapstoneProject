#!/bin/bash
set -x
IMAGE_NAME="capstoneproject_guvi"
IMAGE_TAG="latest"
DEV_REPO="manoharms/reactapp-dev"
PROD_REPO="manoharms/reactapp-prod"
#BRANCH=$(git rev-parse --abbrev-ref HEAD)
#echo "CurrentBranch=$BRANCH"
BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null || echo "DETACHED")
echo "Current branch: $BRANCH"

COMPOSE_FILE="docker-compose.yml"

# Build Docker image

docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Push to Docker Hub based on the current branch
if [ "$BRANCH" == "dev" ]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $DEV_REPO:$IMAGE_TAG
    docker push $DEV_REPO:$IMAGE_TAG
elif [ "$BRANCH" == "main" ]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $PROD_REPO:$IMAGE_TAG
    docker push $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch. Image won't be pushed."
fi

