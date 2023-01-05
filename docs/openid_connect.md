# Concepts de base

## Le protocole OpenID Connect

### Introduction

Inclusion Connect fonctionne avec le protocole OpenID Connect. Ce protocole est une surcouche d'identification au protocole OAuth 2.0 qui permet à des Clients (les fournisseurs de service) d'accéder à l'identité des Utilisateurs finaux (les internautes) par l'intermédiaire d'un serveur d'autorisation (Inclusion Connect).

Les fournisseurs de service doivent donc être des clients OpenID Connect (aussi appelés _relying parties_). Inclusion Connect est un fournisseur OpenID Connect (aussi appelé _OpenID Connect Provider_).

La spécification du protocole se trouve sur http://openid.net/connect/.

Pour une référence d'implémentation OpenID Connect voici le lien : http://openid.net/specs/openid-connect-core-1_0.html

### Les Flux Standards

Le protocole OpenID Connect définit 3 appels REST faits par le client, et 4 endpoints (un du côté client, et trois du côté provider).

En amont, le client s'inscrit (en général manuellement) auprès du provider. Il lui fournit une URL de callback (l'URL du client vers lequel l'internaute est redirigé une fois authentifié), aussi appelée "callback endpoint". En retour le provider donne au client un client ID et un client secret.

Lorsque l'internaute clique sur le bouton d'authentification du client, le flux est le suivant :

- Le client fait une redirection vers le "authorization endpoint" du provider avec son client id et son url de callback. Le provider redirige alors l'internaute vers sa mire d'authentification. Si l'internaute se loggue correctement, le provider renvoie un code d'autorisation au client.
- Le client fait un appel Web service vers le "token endpoint" du provider avec le code d'autorisation reçu, et authentifie cette requête avec son client id et son client secret. Le provider retourne un _access token_ (une chaîne de caractères encodée en base64), un id token (sous la forme d'un Json Web Token), et parfois un refresh token (une chaîne de caractères en base64).
- Le client fait un appel Web service vers le "userInfo endpoint" du provider avec l'_access token_ reçu, et le provider renvoie les informations de l'internaute au client.

Enfin, lorsque l'internaute se déconnecte du fournisseur de service, on s'attend à ce qu'une redirection soit faite vers le "logout endpoint" du provider afin de clore la session en cours.

[Cet article de blog](https://developer.okta.com/blog/2019/10/21/illustrated-guide-to-oauth-and-oidc) (en anglais) illustre très bien le fonctionnement.

## Les données usagers

Les données usagers sont fournies par Inclusion Connect, conformément à l'habilitation obtenue.
Ces données comprennent :

- Email
- Nom de famille
- Prénom

Inclusion Connect transmet systématiquement au Fournisseur de Service un identifiant unique pour chaque utilisateur.

# Utiliser Inclusion Connect pour authentifier des utilisateurs

Afin d'implémenter Inclusion Connect, il faut un compte pour votre fournisseur de service sur les plateformes d'intégration et de production.

## Nos endpoints

Le format des urls est le suivant :

|               |                                                                              |
|           --- | ---                                                                          |
| Authorization | https://{hostname}/realms/{realm-name}/protocol/openid-connect/auth          |
| Registration  | https://{hostname}/realms/{realm-name}/protocol/openid-connect/registrations |
| Token         | https://{hostname}/realms/{realm-name}/protocol/openid-connect/token         |
| UserInfo      | https://{hostname}/realms/{realm-name}/protocol/openid-connect/userinfo      |
| Logout        | https://{hostname}/realms/{realm-name}/protocol/openid-connect/logout        |
| Login-Reset   | https://{hostname}/realms/{realm-name}/login-actions/reset-credentials       |

Contactez l'équipe du projet pour obtenir les variables de production et de recette.

## Détail du fonctionnement

```mermaid
sequenceDiagram
Note right of Utilisateur: L'utilisateur clique sur le bouton "Inclusion Connect"
Utilisateur ->> FS: ;
FS -->> Utilisateur: Redirect 302 <IC_URL>/protocol/openid-connect/auth
Utilisateur ->> Inclusion Connect: GET <IC_URL>/protocol/openid-connect/auth
Inclusion Connect -->> Utilisateur: Redirect 302 <FS_URL>/<URL_CALLBACK>
Utilisateur ->> FS: GET <FS_URL>/<URL_CALLBACK>
FS ->> Inclusion Connect: POST <IC_URL>/protocol/openid-connect/token
Inclusion Connect -->> FS: HTTP Response 200
FS ->> Inclusion Connect: POST <IC_URL>/protocol/openid-connect/userinfo
Inclusion Connect -->> FS: HTTP Response 200
FS -->> Utilisateur: Redirect 302 <FS_URL>/page_authentifée
Note right of Utilisateur: Plus tard l'utilisateur se déconnecte du fournisseur de service
Utilisateur ->> FS: ;
FS -->> Utilisateur: Redirect 302 <IC_URL>/protocol/openid-connect/logout
Utilisateur ->> Inclusion Connect: GET <IC_URL>/protocol/openid-connect/logout
Inclusion Connect -->> Utilisateur: Redirect 302 <FS_URL>/<POST_LOGOUT_REDIRECT_URI>
Utilisateur ->> FS: GET <FS_URL>/<POST_LOGOUT_REDIRECT_URI>
```

## Détail des flux

Le détail des flux peut être trouvé
[en anglais sur cette page](https://openid.net/specs/openid-connect-core-1_0.html).

### 1) Authentification / Création de compte

#### Description

- Contexte : Le FS redirige l'utilisateur vers l'endpoint _Authorization_ pour engager la cinématique d'authentification.
- Origine : FS
- Cible : Inclusion Connect
- Type d'appel : redirection navigateur

#### Requête

- URL : `https://{hostname}/realms/{realm-name}/protocol/openid-connect/auth?response_type=code&client_id=<CLIENT_ID>&redirect_uri=<FS_URL>%2F<URL_CALLBACK>&scope=<SCOPES>&state=><STATE>&nonce=<NONCE>`
- Méthode : GET

Les paramètres sont les suivants :
- **response_type** : Le type de cinématique d'authentification utilisée. Comme nous n'utilisons que le _Authorization Code Flow_ la valeur à donner est `code`.
- **client_id** : l'identifiant du FS.
- **redirect_uri** : l'uri de redirection à laquelle sera envoyée la réponse d'Inclusion Connect.
- **scope** : les ressources auxquelles on souhaite avoir accès. Il faut utiliser `openid profile email`.
- **state** : valeur générée aléatoirement par le FS qu'Inclusion Connect renvoie tel quel dans la réponse à cet appel pour être ensuite vérifié par le FS. Il est utilisé afin d’empêcher l’exploitation de failles CSRF.
- **nonce** : valeur générée aléatoirement par le FS qu'Inclusion Connect renvoie tel quel dans la réponse à l'appel à /token, pour être ensuite vérifié par le FS. Il est utilisé pour empêcher les attaques par rejeu.
- **from** : paramètre supplémentaire utilisé par Inclusion Connect afin de personnaliser le template en ajoutant un logo. Les valeurs acceptées actuellement sont `emplois`, `dora` et `communaute`.
- **login_hint**: paramètre supplémentaire utilisé par Inclusion Connect afin de préremplir une adresse e-mail dans le formulaire de création de compte sur Inclusion Connect. Attention : le formulaire ne bloque pas l'édition et il faudra donc vérifier que l'utilisateur a conservé cet email à l'aide de l'_access token_ plus tard.

L'Utilisateur pourra se connecter s'il possède un compte, ou créer un compte en suivant le lien "Se créer un compte".

Il est possible d'utiliser l'endpoint _Registration_ (avec les mêmes paramètres) pour que l'utilisateur arrive directement sur cette seconde page.
Cet endpoint possède deux paramètres de plus pour faciliter la migration de comptes :
- **firstname**: permet de pré-remplir le prénom de l'utilisateur
- **lastname**: permet de pré-remplir le nom de famille de l'utilisateur
Sur cette page, les champs pré-remplis ne sont pas modifiables. Cela permet de s'assurer qu'un utilisateur existant d'une plateforme qui migre son compte à Incluion Connect ne change pas son email (ce qui empêcherait la plateforme de le reconnaitre).

Note : il est possible d'ajouter des paramètres supplémentaires via la redirect_uri, à passer après ? sous la forme clé=valeur. Ils seront renvoyés tels quels lors du retour vers le FS.

Une fois sur Inclusion Connect, il y a 3 possibilités.
- Si c'est un nouvel utilisateur, il devra se créer un compte, puis recevra un email de vérification d'adresse email qui le renverra sur Inclusion Connect avant d'être redirigé sur **redirect_uri**.
- Si c'est un utilisateur existant non connecté, il devra entrer ses identifiants et sera ensuite redirigé sur **redirect_uri**.
- Si c'est un utilisateur déjà connecté, il sera directement redirigé sur **redirect_uri**.

#### Réponse

HTTP 302 - Redirection vers **redirect_uri***

### 2) Réponse à l'authentification

#### Description

- Contexte : L'utilisateur a complété la cinématique sur Inclusion Connect qui appelle le callback du FS avec un code d'autorisation dans l'URL.
- Origine : Inclusion Connect
- Cible : FS
- Type d'appel : redirection navigateur

#### Requête

- URL : <FS_URL>/<URL_CALLBACK>?code=<AUTHZ_CODE>"&state=<STATE>
- Méthode : GET

Les paramètres sont les suivants :
- **code** : code à réutiliser lors de l'appel sur le endpoint _Token_.
- **state** : la valeur passée lors de l'appel à l'endpoint _Authorisation_ et qu'il faut donc vérifier par sécurité.

### 3) Récupération d'un _Access Token_

#### Description

- Contexte : Le FS a reçu le code d'autorisation. Il doit maintenant demander un _access token_ à Inclusion Connect.
- Origine : FS
- Cible : Inclusion Connect
- Type d'appel : appel de web service

#### Requête

- URL : `https://{hostname}/realms/{realm-name}/protocol/openid-connect/token`
- Méthode : POST
- Header attendu: `Content-Type: application/x-www-form-urlencoded`
- Body: au format "key1=value1&key2=value2" (adapté au content-type `application/x-www-form-urlencoded` )

Voici le payload à envoyer :
- **grant_type**' : `authorization_code` (valeur imposée par le protocol).
- **redirect_uri**' : à nouveau LA MÊME uri de redirection passée à l'endpoint _Authorization_ '<FS_URL>/<CALLBACK_URL_DATA>'.
- **client_id** : l'identifiant du FS.
- **client_secret** : le secret du FS correspondant à son identifiant.
- **code** : le code reçu en réponse à la requête d'authentification.


#### Réponse

Corps HTTP:
```
{
  'access_token': <ACCESS_TOKEN>,
  'token_type': 'Bearer',
  'expires_in': 60,
  'id_token': <ID_TOKEN>
}
```

L'_access token_ sera ensuite utilisé pour accéder à l'endpoint _UserInfo_.

L'_id token_ est un objet JWT signé qui contient notamment :
- **nonce** : la valeur transmise lors de la requête initiale qu'il faut vérifier.
- **sub** : l'identifiant unique de l'utilisateur que le FS doit conserver au cas où l'utilisateur change son adresse e-mail un jour (ce qui n'est pas encore possible pour le moment).
- **given_name** : le prénom de l'utilisateur.
- **family_name** : son nom de famille.
- **email** : son adresse e-mail.


La signature du token est chiffrée avec l'algorithme `RS256` et il est possible de récupérer la clé publique sur une API
de keycloak pour vérifier la signature.

Cependant, dans le cas où l'_access token_ est  récupéré via un appel direct du _backend_ au _OpendID Connect provider_ (Inclusion Connect)
et non par exemple récupéré par le _frontend_ puis transmis au _backend_, la validation du token ne protège pas grand-chose.
En effet, si Inclusion Connect a été compromis, ou si ses réponses sont modifiées par un attaquant, alors celui-ci pourra vraisemblablement
aussi modifier la réponse de l'endpoint pour récupérer la clé publique et y mettre la sienne.

Ce cas précis est d'ailleurs mentionné dans le document de l'IETF "OAuth 2.0 for Browser-Based Apps" :
https://datatracker.ietf.org/doc/html/draft-ietf-oauth-browser-based-apps#section-9.8.3

> Performing OpenID Connect using the Authorization Code flow provides the benefit of the client not needing to verify the JWT signature,
> as the ID token will have been fetched over an HTTPS connection directly from the authorization server.

### 4) Récupération des informations de l'utilisateur

Note: Cette étape est actuellement facultative car toutes les informations que l'on peut récupérer sur cet endpoint
sont déjà présentent dans l'id_token.

#### Description

- Contexte : Le FS interroge Inclusion Connect pour récupérer les informations de l'utilisateur.
- Origine : FS
- Cible : Inclusion Connect
- Type d'appel : appel de web service

#### Requête

- URL :  `https://{hostname}/realms/{realm-name}/protocol/openid-connect/userinfo`
- Méthode : GET. La transmission du token JWT _access_token_ DOIT se faire dans le header `Authorization : Bearer <Token>`.

#### Réponse

Corps HTTP:
```
{
    'sub': <l'identifiant unique de l'utilisateur>
    'given_name': <prénom>,
    'family_name': <nom de famille>
    'email': <l'email>
}
```

Note : il faut que le FS conserve la valeur de sub en base de donnée car c'est celle-ci qui permettra d'identifier l'utilisateur s'il choisit de changer
son adresse email dans Inclusion Connect (ce qui n'est pas encore possible pour le moment).

### 5) Déconnexion

Lorsqu'un utilisateur se déconnecte d'un FS, on s'attend à ce que le FS appelle l'endpoint _Logout_ d'Inclusion Connect.

Cela peut être fait de deux manières :

#### GET

Un appel GET sur l'url `https://{hostname}/realms/{realm-name}/protocol/openid-connect/logout?state=<STATE>&id_token_hint=<ID_TOKEN>`
en réutilisant le **state** et le **id_token** (le paramètre **id_token_hint** permet de ne pas demander de confirmation).

#### Redirect

##### Sans confirmation

On redirige l'utilisateur sur `https://{hostname}/realms/{realm-name}/protocol/openid-connect/logout?state=<STATE>&id_token_hint=<ID_TOKEN>&post_logout_redirect_uri=<FS_URL>%2F<POST_LOGOUT_REDIRECT_URI>`
qui sera ensuite redirigé vers l'url passée avec le paramètre **post_logout_redirect_uri**.


##### Avec confirmation

Si le `STATE` et/ou l'`ID_TOKEN` ne sont pas disponibles, il est possible de déconnecter l'utilisateur avec une redirection  vers `https://{hostname}/realms/{realm-name}/protocol/openid-connect/logout?client_id=<CLIENT_ID>&post_logout_redirect_uri=<FS_URL>%2F<POST_LOGOUT_REDIRECT_URI>`.
Dans ce cas, l'utilisateur devra confirmer sa volonté de se deconnecter d'Inclusion Connect et sera ensuite redirigé vers l'url passée avec le paramètre **post_logout_redirect_uri**.

### 6) Ré-initialisation de mots de passe

On accède généralement à cette page en cliquant sur "Mot de passe oublié" depuis la page de connexion.

Cependant il est possible d'envoyer directement un utilisateur sur cette page, ce qui est utile notamment dans
le cas où l'on a importé des utilisateurs d'une plateforme dans Inclusion Connect et où ils ne leur reste qu'à
changer de mot de passe pour activer leur compte.

Voici le fonctionnement dans ce cas.

#### Description

- Contexte : Le FS redirige l'utilisateur vers l'endpoint _Login-Reset_
- Origine : FS (par exemple lien dans un email)
- Cible : Inclusion Connect
- Type d'appel : redirection navigateur

#### Requête

- URL : `https://{hostname}/realms/{realm-name}/login-actions/reset-credentials`
- Méthode : POST

Voici les arguments que l'on peut ajouter à l'url :
- **email** : l'adresse email de l'utilisateur. Cela lui permet de ne pas re-saissir son email sur cette page
et facilite donc l'activation de son compte.
