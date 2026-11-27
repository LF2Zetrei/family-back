# WHAT I HAVE LEARNT IN THIS PROJECT #

## Spring profiles

I can create different profiles, one for prod, one for dev. For this, I create 2 other .properties files in src/main/resources : application-dev.properties and application-prod.properties. The name is always application-<profile>.properties.

In application.properties, I keep the values that never change between dev and prod. Each profile file only has what is different. If a key is in both, the profile wins.

To select the profile : SPRING_PROFILES_ACTIVE=dev (or prod). Without it, Spring uses "default" and here the app crashes because there is no datasource.

${VAR:value} in Spring = value used if VAR is missing. ${VAR} without default in prod = the app doesn't start (it tries to use "${VAR}" as is).

## Docker

Multi-stage Dockerfile : a first image with maven builds the jar, the final image only has the JRE and the jar. So the maven image vulnerabilities are not in the final image.

depends_on is not enough, the db needs a healthcheck + condition: service_healthy.

In compose the default value is ${VAR:-value} (not the same as Spring !).

## Secrets

Never put passwords in the image or in a committed file. .env in local (git ignored), GitHub secrets for the CI/CD.
