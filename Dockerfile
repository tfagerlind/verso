FROM python:3.10.1-alpine3.15

RUN apk update && \
    apk add --no-cache bats=1.5.0-r0

WORKDIR /app

COPY requirements.txt .

RUN pip install --disable-pip-version-check --no-cache-dir \
                -r requirements.txt && pip check

COPY . .
