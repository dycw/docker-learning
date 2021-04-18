# https://stackoverflow.com/a/61751745

FROM python:slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install -U pip \
  && apt-get update \
  && apt install -y curl git netcat \
  && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
# need git because of https://github.com/python-poetry/poetry/pull/2105
ENV PATH="${PATH}:/root/.poetry/bin"

# WORKDIR /usr/src/app
WORKDIR /myapp
COPY . .
RUN poetry config virtualenvs.create false \
  && poetry install --no-ansi --no-interaction

# run entrypoint.sh
# ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
CMD [ "python", "./app/main.py" ]
