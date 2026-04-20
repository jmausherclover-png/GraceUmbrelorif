# ── Grace Umbrelorif ─────────────────────────────────────────────────────────
# Single Dockerfile for the monorepo.
# Set the SERVICE build-arg (or runtime env var) to "frontend" or "backend"
# (default: backend).
# ─────────────────────────────────────────────────────────────────────────────

FROM node:18-alpine

# Install bash (alpine ships with sh only)
RUN apk add --no-cache bash

WORKDIR /app

# Copy the entire monorepo so start.sh can reach either service directory
COPY . .

# Make the entrypoint executable
RUN chmod +x start.sh

# Default service is backend (override at runtime with -e SERVICE=frontend)
ENV SERVICE=backend

# Expose both ports; Railway will route to whichever $PORT is assigned
EXPOSE 5000 3000

CMD ["bash", "start.sh"]
