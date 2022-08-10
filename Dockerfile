# Dockerfile used **in a production environment** as this is the default location of a Dockerfile.
# NB: This is the default location for the Dockerfile
FROM quay.io/keycloak/keycloak:latest
COPY ./themes/inclusion-connect/ /opt/keycloak/themes/inclusion-connect/
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
# The spi-connections-jpa-default-migration-strategy option is here
# to upgrade the database from v16.1.1
# see https://www.keycloak.org/docs/latest/upgrading/#_migrate_db
CMD ["start", "--spi-connections-jpa-default-migration-strategy", "update"]