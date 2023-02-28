# Se connecte à la CLI
/opt/keycloak/bin/kcadm.sh config credentials --server http://keycloak:8080 --realm master --user admin --password password
# Crée le royaume
/opt/keycloak/bin/kcadm.sh create realms -s realm=local
/opt/keycloak/bin/kcadm.sh update realms/local \
    -s enabled=true \
    -s registrationAllowed=true \
    -s registrationEmailAsUsername=true \
    -s editUsernameAllowed=true \
    -s verifyEmail=true \
    -s resetPasswordAllowed=true \
    -s accountTheme=inclusion-connect \
    -s loginTheme=inclusion-connect \
    -s emailTheme=inclusion-connect \
    -s smtpServer.host=smtp \
    -s smtpServer.port=1025 \
    -s smtpServer.fromDisplayName="Inclusion Connect" \
    -s smtpServer.from=inclusion@connect.fr \
    -s internationalizationEnabled=true \
    -s 'supportedLocales=["fr"]' \
    -s defaultLocale=fr \
    -s passwordPolicy="length(8) and digits(1) and upperCase(1) and specialChars(1)" \
    -s actionTokenGeneratedByUserLifespan=86400
# Enable terms page
/opt/keycloak/bin/kcadm.sh update realms/local/authentication/required-actions/terms_and_conditions -s enabled=true -s defaultAction=true

# realm=local                       # Nom du royaume
# enabled=true                      # Active le royaume
# registrationAllowed=true          # Permet là des utilisateurs de créer des comptes
# registrationEmailAsUsername=true  # email == username
# editUsernameAllowed=true          # Permet de mettre à jour son email
# verifyEmail=true                  # Force la vérification de l'email
# resetPasswordAllowed=true         # Permet de redemander un mot de passe
# loginTheme=inclusion-connect      # Utilise notre theme pour la mire de connexion
# emailTheme=inclusion-connect      # Utilise notre theme pour les emails
# accountTheme=inclusion-connect    # Utilise notre theme pour l'espace personnel
# smtpServer.host=smtp              # Docker compose utilise le nom du dervice comme hostname
# actionTokenGeneratedByUserLifespan -> 24 heures

# Crée le client pour utiliser le SSO
/opt/keycloak/bin/kcadm.sh create clients \
    -r local \
    -s clientId=local_inclusion_connect
# Récupère le client id pour mettre à jour sa configuration
CLIENT_ID=$(/opt/keycloak/bin/kcadm.sh get clients -r local -q clientId=local_inclusion_connect --fields=id --format=csv | tr -d '"')
/opt/keycloak/bin/kcadm.sh update clients/$CLIENT_ID \
    -r local \
    -s enabled=true \
    -s secret="password" \
    -s clientAuthenticatorType=client-secret \
    -s 'redirectUris=["*"]' \
    -s 'attributes={"post.logout.redirect.uris": "+"}'

echo "================================================"
echo "client_id     = local_inclusion_connect"
echo "client_secret = password"
echo "================================================"
