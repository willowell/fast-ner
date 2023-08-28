# Fast-NER

Provides an API for spaCy's `en_core_web_lg`'s Named Entity Recognition (NER) capabilities, via FastAPI.

You can run this API locally on your computer or inside a Docker container using the provided `docker-compose.*.yaml` and `.dockerfile` files.

> :warning: Do not use the Docker container as-is for production use. For starters, the Docker container mounts `/app` as a volume, ignoring the `.dockerignore` settings, and it configures Uvicorn for live reload.

## Requirements

* Python 3.11
* [Poetry](https://python-poetry.org/)

## How to run the FastAPI server directly on your computer

1. Run `poetry install` to collect the dependencies.
2. Run `make fetch-spacy-models` (alias for `poetry run python -m spacy download en_core_web_lg`) to download the spaCy `en_core_web_lg` model. Please be pateint; the model is ~500 MB!
3. Run `make dev` (alias for `poetry run python -m uvicorn --reload --port 8000 --log-level info "fast-ner.main:app"`) to run the server.
4. If all goes well, the server will be ready at `http://localhost:8000`.

## How run the FastAPI server using the Docker container

1. Run `dev-compose` (alias for `docker compose -f docker-compose.dev.yaml up`).
2. If all goes well, the server will be ready at `http://localhost:8000`.
