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
until curl -f http://localhost:8080 || exit 1
do
  sleep 2 
  echo "."
  TIMER=$((TIMER + 2))

  if [[ $TIMER -eq 60 ]]; then
    echo "Keycloak did not initialize within 60 seconds. Exiting."
    exit 2
  fi
done
echo "::endgroup::"