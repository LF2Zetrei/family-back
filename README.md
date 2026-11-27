# SPRING BOOT API

## Prerequisites

- Docker + Docker Compose
- Java 25 (only to run the app outside Docker)

## Configuration

Create your `.env` from the example, then set a real password:

```bash
cp .env.example .env
```

Spring profiles:

- `dev`: SQL logs, debug logs, every actuator endpoint. Datasource has local defaults.
- `prod`: minimal logs and actuator. No defaults: the app refuses to start if a datasource variable is missing.

## Useful commands (Docker)

```bash
docker compose up -d --build                        # start api + db (profile from .env, dev by default)
SPRING_PROFILES_ACTIVE=prod docker compose up -d    # start api + db with the prod profile
docker compose logs -f family-api                   # follow api logs
docker compose --profile test run --rm --build tests  # run the tests (profile from .env)
docker compose down                                 # stop everything (data is kept)
docker compose down -v                              # stop everything and delete the database volume
```

## Run locally without Docker for the API

The database still runs in Docker, reachable on `localhost:5434`:

```bash
docker compose up -d db
export DATASOURCE_PASSWORD=<password from .env>
./mvnw spring-boot:run -Dspring-boot.run.profiles=dev
```

The API is then on http://localhost:8080 (health check: `/actuator/health`).
