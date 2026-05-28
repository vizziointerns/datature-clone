from __future__ import annotations

from collections.abc import Generator

from sqlalchemy import create_engine
from sqlalchemy.engine import Engine
from sqlalchemy.orm import Session, sessionmaker

from app.core.config import settings


def _create_engine() -> Engine:
    url = settings.database_url
    connect_args: dict[str, object] | None = None
    if url.startswith("sqlite:"):
        connect_args = {"check_same_thread": False}
    return create_engine(url, pool_pre_ping=True, connect_args=connect_args or {})


engine = _create_engine()
SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False, class_=Session)


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
