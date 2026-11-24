# Behavioral Portfolio Lab

A single FastAPI + React app that profiles an investor with prospect theory, builds a mean-CVaR portfolio, and evaluates disciplined versus behavioral investment policies.

## Run on Windows (no Docker)

```bash
powershell -ExecutionPolicy Bypass -File .\run-app.ps1
```

The launcher sets up dependencies, builds the frontend the first time, starts the app, and opens http://localhost:8000. Keep the PowerShell window open while using the app; press **Ctrl+C** there to stop it.

## Run with Docker (optional)

```bash
docker compose up --build
```

Open http://localhost:8000.

## Project

Project A: `project-a-behavioral-portfolio/`
