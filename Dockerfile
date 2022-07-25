FROM curlimages/curl:latest
COPY start-keycloak-dev.sh /start-keycloak-dev.sh
RUN chmod +x /start-keycloak-dev.sh
ENTRYPOINT ["/start-keycloak-dev.sh"]
