# Développer sur Inclusion Connect

NB: Pour l'instant la procédure qui suit ne fonctionne pas. À corriger lors de la mise à jour de KeyCloak

## Prérequis

Pour développer sur Inclusion Connect, il vous faudra un ordinateur avec les logiciels suivants:
- git
- docker

## Cloner le repo GitHub

La première étape est de cloner le repo sur votre ordinateur.

## Base de données

KeyCloak utilise par défaut une base de données H2.

Sur CleverCloud nous utilisons un PostgreSQL, mais ce n'est pas la peine d'en 
configurer un en local car le H2 suffit.

## Variables d'environnement

Il faut ensuite compléter ou modifier les variables d'environnement.

```bash
cp dev.env.template dev.env
vim dev.env
```

## Lancer le service en local

Il ne reste plus qu'à lancer la commande suivante depuis la racine du repo :

```bash
docker-compose up
```