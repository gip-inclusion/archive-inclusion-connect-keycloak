ARG GRADLE_CLI_OPTS=''
FROM gradle:7.1.1-jdk11 AS build
COPY ./keycloak-customisation /keycloak-customisation
WORKDIR /keycloak-customisation
RUN gradle clean jar

# Dockerfile for local environment
FROM quay.io/keycloak/keycloak:20.0.0
COPY --from=build keycloak-customisation/build/libs/pass-emploi-keycloak-customisation-0.0.1-SNAPSHOT.jar /opt/jboss/keycloak/standalone/deployments/pass-emploi-keycloak-customisation.jar
# theme is mounted with docker file so that we don't have to create a new docker image
# for every change in the theme.

# Disable Impersonation
ENV KC_FEATURES_DISABLED=impersonation

# Use start-dev command instead of start
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
