# Stage 1 : builder 
FROM python:3.12-slim AS builder

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

WORKDIR /app

# Copy dependency
COPY pyproject.toml uv.lock ./

# Install dependencies to virtual environment
# frozen ensures we stick strictly to the lockfile
RUN uv sync --frozen --no-install-project

# Stage 2 : Runtime
FROM python:3.12-slim

WORKDIR /app

# Copy the virtual environment from the builder stage
COPY --from=builder /app/.venv /app/.venv

# Copy application code
COPY src ./src

# Enable the virtual environment in the path
ENV PATH="/app/.venv/bin:$PATH"

# Run the application
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]