while [ $(docker inspect --format='{{.State.Health.Status}}' $1) != "healthy" ]; do sleep 1; echo -n "."; done