# FROM python:3.14.2-slim-trixie 

# RUN useraddd --no-create-home --pid 10001 --shell /usr/sbin/nologin appuser 

# # create workdir app
# WORKDIR /app

# COPY pyproject.toml ./

# RUN pip install --no-cache-dir .

# COPY --chown=appuser:appuser . .

# # change app ownership to appuser

# USER appuser

# EXPOSE 9000/tcp

# CMD ["python","-m","uvicorn","main:app","--host","0.0.0.0","--port","9000"]

# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

# This Dockerfile uses Docker Hardened Images (DHI) for enhanced security.
# For more information, see https://docs.docker.com/dhi/

# Use the dev image to build and install dependencies.
FROM dhi.io/python:3.14-dev AS builder

WORKDIR /app

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# this layer.

COPY pyproject.toml .

RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    pip install --no-cache-dir .

# Use the minimal runtime image. It runs as nonroot by default.
FROM dhi.io/python:3.14

WORKDIR /app

COPY --from=builder /venv /venv
ENV PATH="/venv/bin:$PATH"

# Copy the source code into the container.
COPY . .

# Expose the port that the application listens on.
EXPOSE 8000

# Run the application.
CMD ["/venv/bin/python3", "-m", "uvicorn", "main:app", "--host=0.0.0.0", "--port=9000"]