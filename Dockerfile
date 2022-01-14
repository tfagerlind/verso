FROM python:3.10.1-alpine3.15

RUN apk update && \
    apk add --no-cache bats=1.5.0-r0

RUN adduser -D verso

USER verso

WORKDIR /app

COPY --chown=verso:verso requirements.txt .

RUN pip install --disable-pip-version-check --no-cache-dir \
                -r requirements.txt && pip check

COPY --chown=verso:verso . .
