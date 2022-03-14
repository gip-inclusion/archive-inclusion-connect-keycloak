# Keycloak

## Environment variables

```yaml
KEYCLOAK_USER: user
KEYCLOAK_PASSWORD: password

SMTP_HOST: smtp.example.com
SMTP_PORT: 465
SMTP_FROM_DISPLAY_NAME: Inclusion Connect
SMTP_FROM: foo@example.com
SMTP_REPLYTO_DISPLAY_NAME: Inclusion Connect
SMTP_REPLYTO: no-reply@example.com
SMTP_SSL: true
SMTP_AUTH: true
SMTP_USER: user
SMTP_PASSWORD: password
```


## Running on local host

```bash
cp .env.template .env
vim .env
docker-compose up
```
