# Behavioral Portfolio Lab

A single FastAPI + React app that profiles an investor with prospect theory, builds a mean-CVaR portfolio, and evaluates disciplined versus behavioral investment policies.

## Run with Docker

```bash
docker compose up --build
```

Open http://localhost:8000.

## Run without Docker

On Windows, run:

```bash
powershell -ExecutionPolicy Bypass -File .\run-app.ps1
```

Open http://localhost:8000.

The script installs Node.js LTS if needed, creates the Python virtual environment, installs dependencies, builds the React frontend, and starts the app.

## Project

Project A: `project-a-behavioral-portfolio/`
