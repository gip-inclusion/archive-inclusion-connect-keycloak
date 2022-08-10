# Se connecte à la CLI
/opt/keycloak/bin/kcadm.sh config credentials --server http://keycloak:8080 --realm master --user admin --password password
# Crée le royaume
/opt/keycloak/bin/kcadm.sh create realms -s realm=local
/opt/keycloak/bin/kcadm.sh update realms/local \
    -s enabled=true \
    -s registrationAllowed=true \
    -s registrationEmailAsUsername=true \
    -s verifyEmail=true \
    -s resetPasswordAllowed=true \
    -s loginTheme=inclusion-connect \
    -s emailTheme=inclusion-connect \
    -s smtpServer.host=smtp \
    -s smtpServer.port=1025 \
    -s smtpServer.fromDisplayName="Inclusion Connect" \
    -s smtpServer.from=inclusion@connect.fr \
    -s internationalizationEnabled=true \
    -s 'supportedLocales=["fr"]' \
    -s defaultLocale=fr
# realm=local                       # Nom du royaume
# enabled=true                      # Active le royaume
# registrationAllowed=true          # Permet là des utilisateurs de créer des comptes
# registrationEmailAsUsername=true  # email == username
# verifyEmail=true                  # Force la vérification de l'email
# resetPasswordAllowed=true         # Permet de redemander un mot de passe
# loginTheme=inclusion-connect      # Utilise notre theme pour la mire de connexion
# emailTheme=inclusion-connect      # Utilise notre theme pour les emails
# smtpServer.host=smtp              # Docker compose utilise le nom du dervice comme hostname

# Crée le client pour utiliser le SSO
/opt/keycloak/bin/kcadm.sh create clients \
    -r local \
    -s clientId=local_inclusion_connect
# Récupère le client id pour mettre à jour sa configuration
CLIENT_ID=$(/opt/keycloak/bin/kcadm.sh get clients -r local -q clientId=local_inclusion_connect --fields=id --format=csv | tr -d '"')
/opt/keycloak/bin/kcadm.sh update clients/$CLIENT_ID \
    -r local \
    -s enabled=true \
    -s clientAuthenticatorType=client-secret \
    -s 'redirectUris=["*"]'

# Affiche le client_id / client_secret pour utiliser le service
CLIENT_SECRET=$(/opt/keycloak/bin/kcadm.sh get clients -r local -q clientId=local_inclusion_connect --fields=secret --format=csv | tr -d '"')
echo "================================================"
echo "client_id     = local_inclusion_connect"
echo "client_secret = $CLIENT_SECRET"
echo "================================================"
