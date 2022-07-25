#!/bin/sh

# Map input values from the GitHub Actions workflow to shell variables
KEYCLOAK_PORT=$1

echo "::group::Starting Keycloak Dev Server"
echo "  - port [$KEYCLOAK_PORT]"
echo ""
docker run --name keycloak-dev --publish $KEYCLOAK_PORT:8080 --detach jboss/keycloak:latest
echo "::endgroup::"

echo "::group::Waiting for Keycloak to accept connections"
sleep 1
TIMER=0
until docker exec --tty keycloak-dev curl -f http://localhost:$KEYCLOAK_PORT
do
  sleep 5 
  echo "."
  TIMER=$((TIMER + 5))

  if [[ $TIMER -eq 90 ]]; then
    echo "Keycloak did not initialize within 60 seconds. Exiting."
    exit 2
  fi
done
echo "::endgroup::"
