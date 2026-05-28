.PHONY: help lint-backend format-backend install-backend run-backend migrate-backend db-up db-down

help:
	@echo "Available targets:"
	@echo "  lint-backend     Run Ruff and MyPy for the backend"
	@echo "  format-backend   Format the backend with Ruff"
	@echo "  install-backend  Create backend venv (if needed) and install requirements"
	@echo "  run-backend      Run backend with uvicorn (dev)"
	@echo "  migrate-backend  Apply Alembic migrations to the configured database"
	@echo "  db-up            Start Postgres via docker compose (dev)"
	@echo "  db-down          Stop Postgres via docker compose (dev)"

lint-backend:
	cd backend && ruff check . && mypy .

format-backend:
	cd backend && ruff format .

install-backend:
	cd backend && test -d venv || python -m venv venv
	cd backend && . venv/bin/activate && pip install -r requirements.txt

run-backend:
	cd backend && uvicorn main:app --reload --host 127.0.0.1 --port 8000

migrate-backend:
	cd backend && alembic upgrade head

db-up:
	docker compose up -d postgres

db-down:
	docker compose down
