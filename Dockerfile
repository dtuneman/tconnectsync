FROM python:3.9-slim

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY Pipfile Pipfile.lock setup.cfg setup.py pyproject.toml ./
RUN pip install pipenv && pipenv requirements > requirements.txt && pip install -r requirements.txt
# Copy application
COPY . .

# Run
ENTRYPOINT ["python3", "-u", "main.py"]
