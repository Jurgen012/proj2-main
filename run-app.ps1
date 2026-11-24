# Run the Behavioral Portfolio app on Windows without Docker.
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$app = Join-Path $root "project-a-behavioral-portfolio"
$backend = Join-Path $app "backend"
$frontend = Join-Path $app "frontend"
$venv = Join-Path $backend ".venv"
$python = Join-Path $venv "Scripts\python.exe"
$npm = Get-Command npm -ErrorAction SilentlyContinue

if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
  throw "Python was not found. Install Python 3.12+ and add it to PATH."
}

if (-not $npm) {
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    Write-Host "Node.js was not found. Installing Node.js LTS..."
    winget install --id OpenJS.NodeJS.LTS -e --source winget --accept-package-agreements --accept-source-agreements
    $nodeDir = Join-Path $env:ProgramFiles "nodejs"
    if (Test-Path $nodeDir) {
      $env:Path = "$nodeDir;$env:Path"
    }
    $npm = Get-Command npm -ErrorAction SilentlyContinue
  }
  if (-not $npm) {
    throw "Node.js/npm is not available. Close and reopen PowerShell after installing Node.js LTS, then run this script again."
  }
}

if (-not (Test-Path $python)) {
  Write-Host "Creating Python virtual environment..."
  Push-Location $backend
  try {
    python -m venv .venv
  } finally {
    Pop-Location
  }
}

Write-Host "Installing/updating backend dependencies..."
Push-Location $backend
try {
  & $python -m pip install --quiet --upgrade pip
  & $python -m pip install --quiet -r requirements.txt
} finally {
  Pop-Location
}

$dist = Join-Path $frontend "dist\index.html"
if (-not (Test-Path $dist)) {
  Write-Host "Installing frontend dependencies and building the app..."
  Push-Location $frontend
  try {
    & npm.cmd ci
    & npm.cmd run build
  } finally {
    Pop-Location
  }
}

Write-Host ""
Write-Host "Starting Behavioral Portfolio..."
Write-Host "Open http://localhost:8000"
Write-Host "Press Ctrl+C to stop."

$env:FRONTEND_DIST = Join-Path $frontend "dist"
Push-Location $backend
try {
  Start-Process "http://localhost:8000"
  & $python -m uvicorn app.api.main:app --host 127.0.0.1 --port 8000
} finally {
  Pop-Location
  Remove-Item Env:\FRONTEND_DIST -ErrorAction SilentlyContinue
}
