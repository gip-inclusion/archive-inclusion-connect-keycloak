#!/usr/bin/env bash
set -euo pipefail

if [[ -z ${BIND:-} ]]; then
    BIND=$(hostname --all-ip-addresses | cut -d " " -f 1)
    export BIND
fi
echo "Binding to $BIND"

setTheme () {
	/opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://$BIND:8080/auth --realm master --user "$KEYCLOAK_USER" --password "$KEYCLOAK_PASSWORD"
	/opt/jboss/keycloak/bin/kcadm.sh update realms/master \
		-s loginTheme=inclusion-connect \
		-s emailTheme=inclusion-connect \
		-s registrationAllowed=true \
		-s registrationEmailAsUsername=true \
		-s smtpServer.host=$SMTP_HOST \
		-s smtpServer.port=$SMTP_PORT \
		-s smtpServer.fromDisplayName="$SMTP_FROM_DISPLAY_NAME" \
		-s smtpServer.from=$SMTP_FROM \
		-s smtpServer.replyToDisplayName="$SMTP_REPLYTO_DISPLAY_NAME" \
		-s smtpServer.replyTo=$SMTP_REPLYTO \
		-s smtpServer.ssl=$SMTP_SSL \
		-s smtpServer.auth=$SMTP_AUTH \
		-s smtpServer.user=$SMTP_USER \
		-s smtpServer.password="$SMTP_PASSWORD"
}

(sleep 15 && setTheme)&
/opt/jboss/tools/docker-entrypoint.sh "$@"
