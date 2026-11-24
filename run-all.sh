#!/usr/bin/env bash
# Run the Behavioral Portfolio app locally without Docker:
#   ./run-all.sh        -> http://localhost:8000
# Ctrl+C stops everything.
#
# Requires the project's backend venv and built frontend:
#   cd project-a-behavioral-portfolio/backend
#   python3 -m venv .venv
#   .venv/bin/pip install -r requirements.txt
#   cd ../frontend
#   npm install && npm run build
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
APP="$ROOT/project-a-behavioral-portfolio"
pids=()
cleanup() { kill "${pids[@]}" 2>/dev/null || true; }
trap cleanup EXIT INT TERM

if [[ ! -x "$APP/backend/.venv/bin/uvicorn" ]]; then
  echo "!! Missing backend/.venv (see header of this script)"
  exit 1
fi
if [[ ! -f "$APP/frontend/dist/index.html" ]]; then
  echo "!! Missing frontend/dist; run 'npm install && npm run build' in project-a-behavioral-portfolio/frontend"
  exit 1
fi

echo "Starting the Behavioral Portfolio app..."
( cd "$APP/backend" && FRONTEND_DIST="$APP/frontend/dist" exec .venv/bin/uvicorn app.api.main:app --host 127.0.0.1 --port 8000 --log-level warning ) &
pids+=($!)
echo ""
echo "   Behavioral Portfolio -> http://localhost:8000"
echo "   Ctrl+C to stop."
wait
