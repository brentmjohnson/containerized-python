FROM python:3.12

# this can be configurable with docker build args but not implemented in tasks.json yet
ARG UID=1000
ARG GID=1000

RUN set -ex \
    && apt-get update \
    && apt-get install -y \
        default-jre-headless \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g ${GID} dev && \
    useradd -m -s /usr/sbin/nologin -u ${UID} -g dev dev

RUN mkdir -p /home/dev/containerized-python
WORKDIR /home/dev/containerized-python

RUN pip install --upgrade build

COPY ./.cache ../.cache/
RUN chown -R dev:dev ../.cache
COPY ./build ./build/
COPY ./dist ./dist/
COPY ./src ./src/
COPY setup.py pyproject.toml \
    ./
RUN chown -R dev:dev .
USER dev

RUN python -m build
RUN pip install .

CMD [ "sh", "-c", \
    "python -m 'main'" \
]

# docker build . --no-cache --progress=plain --tag=containerized-python
# docker build . --tag=containerized-python
# docker run --rm -it  containerized-python:latest