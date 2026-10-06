FROM python:3.12-slim-bookworm

ARG VCS_REF=unknown
ARG VCS_URL="https://github.com/sherlock-project/sherlock"
ARG VERSION_TAG=0.16.2

ENV SHERLOCK_ENV=docker \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.name="Sherlock" \
      org.label-schema.version=$VERSION_TAG \
      website="https://sherlockproject.xyz"

WORKDIR /sherlock

# Install the checked-out source so the image always matches this repository.
COPY pyproject.toml .
COPY docs/pyproject/README.md ./docs/pyproject/README.md
COPY sherlock_project ./sherlock_project
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir . \
    && useradd --create-home --shell /usr/sbin/nologin sherlock

USER sherlock
ENTRYPOINT ["sherlock"]
