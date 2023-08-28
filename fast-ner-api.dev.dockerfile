# Fast NER API
#
# Images used:
#
# * python (Docker Official Image)
#     * Docker Hub: https://hub.docker.com/_/python
#
# * tiangolo/uvicorn-gunicorn-fastapi
#     * GitHub: https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker
#     * Docker Hub: https://hub.docker.com/r/tiangolo/uvicorn-gunicorn-fastapi
#
#
#======================================================================================================================#
# REQUIREMENTS STAGE                                                                                                   #
#======================================================================================================================#

FROM python:3.11 as requirements-stage

WORKDIR /tmp

RUN pip install poetry

COPY ./pyproject.toml ./poetry.lock* /tmp/

RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

#======================================================================================================================#
# APP STAGE                                                                                                            #
#======================================================================================================================#

FROM tiangolo/uvicorn-gunicorn-fastapi:python3.11

LABEL name="fast-ner-api"
LABEL version="0.1.0"
LABEL description="FastAPI spaCy NER Image"
LABEL maintainer="William Howell <wlm.howell@gmail.com>"

COPY --from=requirements-stage /tmp/requirements.txt /app/requirements.txt

# Install pip modules

RUN pip install --no-cache-dir --upgrade -r /app/requirements.txt

# Install ML models

# Install en_core_web_lg - https://spacy.io/models/en#en_core_web_lg
RUN python -m spacy download en_core_web_lg

# Copy app code last to take advantage of Docker's cache.
# Otherwise, changes in the source code will bust Docker's cache for the dependencies,
# which means Docker will reinstall them even if they have not changed.

# Especially since this image uses a large spaCy model, it's not a good idea to bust the cache!

# Skip this step if using volumes
# If you use this as-is, the code will be copied once as-is, which means `uvicorn --reload` is useless.
# COPY ./app /app
