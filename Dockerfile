    # Use the official Python 3.11 image as the base image
    FROM python:3.11-slim

    # Set environment variables to avoid creating .pyc files
    ENV PYTHONUNBUFFERED=1
    ENV PYTHONDONTWRITEBYTECODE=1
    RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
    # Install Poetry
    RUN pip install poetry

    # Set the working directory in the container
    WORKDIR /app

    # Copy the pyproject.toml and poetry.lock files to the container
    COPY pyproject.toml poetry.lock /app/

    # Install dependencies
    RUN poetry install --no-root

    # Copy the rest of the application code to the container
    COPY . /app

    EXPOSE 8051

    # Set the entry point to your application (adjust this as needed)
    CMD ["poetry", "run", "python", "ocr_app.py"]
