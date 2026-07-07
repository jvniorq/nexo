from datetime import UTC, datetime
from enum import StrEnum
from uuid import UUID, uuid4

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field


class Space(StrEnum):
    personal = "personal"
    household = "household"


class HealthResponse(BaseModel):
    status: str
    service: str


class TaskCreate(BaseModel):
    title: str = Field(min_length=1, max_length=240)
    space: Space = Space.personal
    due_at: datetime | None = None


class TaskResponse(TaskCreate):
    id: UUID
    completed: bool = False
    created_at: datetime


app = FastAPI(
    title="Nexo API",
    version="0.1.0",
    description="API foundation for personal and household organization.",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:7357"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/health", response_model=HealthResponse, tags=["system"])
def health() -> HealthResponse:
    return HealthResponse(status="ok", service="Nexo API")


@app.post(
    "/api/v1/tasks",
    response_model=TaskResponse,
    status_code=201,
    tags=["tasks"],
)
def create_task(payload: TaskCreate) -> TaskResponse:
    """Initial contract; PostgreSQL persistence will be added later."""
    return TaskResponse(
        id=uuid4(),
        title=payload.title,
        space=payload.space,
        due_at=payload.due_at,
        completed=False,
        created_at=datetime.now(UTC),
    )
