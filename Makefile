.PHONY: fetch-spacy-models
fetch-spacy-models:
	poetry run python -m spacy download en_core_web_lg

.PHONY: dev
dev:
	poetry run python -m uvicorn --reload --port 8000 --log-level info "fast-ner.main:app"

.PHONY: dev-compose
dev-compose:
	docker compose -f docker-compose.dev.yaml up

.PHONY: run
run:
	poetry run python -m uvicorn --port 8000 --log-level info "fast-ner.main:app"
