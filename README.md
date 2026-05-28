# Datature Clone

Monorepo:

- `frontend/`: React + TypeScript + Vite (pnpm)
- `backend/`: FastAPI + Python 3.12

## Prerequisites

- Node.js 20+
- pnpm 9+
- Python 3.12+
- (Optional) Docker Desktop (for local Postgres)

## Quick Start

### 1) Backend

Create and activate the virtual environment:

```powershell
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

Create local environment file:

```powershell
Copy-Item .env.example .env -Force
```

Run migrations (SQLite by default):

```powershell
alembic upgrade head
```

Run the API:

```powershell
uvicorn main:app --reload --host 127.0.0.1 --port 8000
```

Health check:

- `GET http://127.0.0.1:8000/api/health`

### 2) Frontend

Install and run:

```powershell
cd ..\frontend
pnpm install
pnpm run dev
```

The frontend dev server proxies `/api` to `http://127.0.0.1:8000`.

## Development Database (Postgres)

Start Postgres:

```powershell
cd ..
docker compose up -d postgres
```

Then set `DATABASE_URL` in `backend/.env`, for example:

```text
DATABASE_URL=postgresql+psycopg://datature:datature@localhost:5432/datature
```

Apply migrations:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
alembic upgrade head
```

## Code Quality

Backend:

```powershell
cd backend
.\venv\Scripts\Activate.ps1
ruff check .
ruff format --check .
mypy .
```

Frontend:

```powershell
cd frontend
pnpm run lint
pnpm run format:check
pnpm run build
```

Pre-commit:

```powershell
cd ..
pip install pre-commit
pre-commit install
pre-commit run --all-files
```

## Makefile

From repo root:

```powershell
make help
make lint-backend
make format-backend
make run-backend
make migrate-backend
make db-up
make db-down
```
