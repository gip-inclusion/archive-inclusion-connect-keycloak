# Dockerfile for local environment
FROM quay.io/keycloak/keycloak:19.0.2
# theme is mounted with docker file so that we don't have to create a new docker image
# for every change in the theme.

# Disable Impersonation
ENV KC_FEATURES_DISABLED=impersonation

# Use start-dev command instead of start
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]