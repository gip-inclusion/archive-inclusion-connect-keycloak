# Développer sur Inclusion Connect

## Prérequis

Pour développer sur Inclusion Connect, il vous faudra un ordinateur avec les logiciels suivants:
- git
- docker

## Cloner le dépôt GitHub

La première étape est de cloner le dépôt sur votre ordinateur.

## Base de données

Notre KeyCloak est configuré pour utiliser une base de données PostgreSQL afin d'avoir de la rémanence de données.

C'est le fichier ``docker-compose.yml`` qui s'occupe de tout pour créer celle-ci.

NB: le port exposé est le `5433` car si vous travaillez déjà avec un PSQL, il est probable que votre port
`5432` soit déjà utilisé.

## Serveur mail de test

Afin d'avoir accès aux mails envoyés par Keycloak, notre `docker-compose.yml` lance une image docker de [MailHog](https://github.com/mailhog/MailHog).

MailHog donne accès à un faux webmail à l'addresse http://0.0.0.0:8025 qui permet d'afficher tous les emails qui sont envoyés.
Cela permet de ne pas avoir besoin d'un vrai serveur SMTP et d'une vraie adresse email.

## Variables d'environnement

Il faut ensuite copier le template des variables d'environnement.
Il n'y a par défaut pas besoin de les modifier pour que tout fonctionne.

```bash
cp docker/dev/dev.env.template docker/dev/dev.env
```

## Lancer le service en local

Il ne reste plus qu'à lancer les images dockers depuis la racine du dépôt :

```bash
docker-compose up
```

## Configuration du KeyCloak

La première fois que vous lancez le service, il faudra configurer Keycloak en lançant le script suivant:

```bash
docker exec -i inclusion_connect_keycloak bash < docker/dev/keycloak/init.sh
```

Pour utiliser le service il faut les identifiantes suivants :
- le `client_id` est `local_inclusion_connect`
- le `client_secret` est `password`

### Testez l'envoi d'email

Connectez vous à l'interface d'administration de keycloak (http://0.0.0.0:8080)
avec le couple `admin/password`.

Sélectionnez le royaume `local` dans le menu déroulant à gauche, puis allez dans `Realm settings`.

Allez dans l'onglet `Email` puis cliquez sur `Test connection` en bas. Après avoir mis n'importe quelle adresse e-mail,
vous devriez voir un email de test dans l'interface de MailHog (http://0.0.0.0:8025/).

## Normalement tout est bon !

Si tout va bien (croisons les doigts) vous aurez accès à `http://0.0.0.0:8080/realms/local/protocol/openid-connect/auth`
et aux autres urls.

Il faudra utiliser le couple `local_inclusion_connect`/`password` comme indiqué précédement.

## En cas de soucis

### La base de données est mal initialisée

Rencontré typiquement si les variables d'environnement sont mal configurée, il faudra supprimer le volume docker
pour ré-initialiser correctement la base de données :

```bash
docker volume rm itou-inclusion-connect_postgres_data
```
