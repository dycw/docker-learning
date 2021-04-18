# https://stackoverflow.com/a/61751745

FROM python3.9:slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install -U pip \
  && apt-get update \
  && apt install -y curl netcat \
  && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH="${PATH}:/root/.poetry/bin"

# WORKDIR /usr/src/app
COPY . .
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# run entrypoint.sh
# ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
CMD [ "python", "./main.py" ]
