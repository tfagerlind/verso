FROM python:3.10.1-alpine3.15

# hadolint ignore=DL3018
RUN apk update && \
    apk add --no-cache bats=1.5.0-r0 git=2.34.1-r0 && \
    # Transient dependencies of the twine python library.
    # Drawn from https://stackoverflow.com/a/53562393
    apk add --no-cache --virtual .build-deps \
        gcc musl-dev python3-dev libffi-dev rust cargo openssl-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install --disable-pip-version-check --no-cache-dir \
                -r requirements.txt && pip check

COPY . .
