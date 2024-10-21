#!/bin/bash
set -x
IMAGE_NAME="guvi"
IMAGE_TAG="latest"
DEV_REPO="manoharms/reactapp-dev"
PROD_REPO="manoharms/reactapp-prod"
BRANCH_NAME="$1"
echo "$BRANCH_NAME"
BRANCH_NAME="${BRANCH_NAME#origin/}"
COMPOSE_FILE="docker-compose.yml"

# Build Docker image

#docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Push to Docker Hub based on the current branch
if ["$BRANCH_NAME" == "dev"]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $DEV_REPO:$IMAGE_TAG
    docker-compose -f $COMPOSE_FILE --build
    docker push $DEV_REPO:$IMAGE_TAG
elif ["$BRANCH_NAME" == "main"]; then
    docker tag $IMAGE_NAME:$IMAGE_TAG $PROD_REPO:$IMAGE_TAG
    docker-compose -f $COMPOSE_FILE --build
    docker push $PROD_REPO:$IMAGE_TAG
else
    echo "No valid branch. Image won't be pushed."
fi

