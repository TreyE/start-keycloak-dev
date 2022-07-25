FROM docker:stable
RUN apk add --no-cache curl ca-certificates
COPY start-keycloak-dev.sh /start-keycloak-dev.sh
RUN chmod +x /start-keycloak-dev.sh
ENTRYPOINT ["/start-keycloak-dev.sh"]
