FROM python:slim
# FROM python:3.9

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE 1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED 1

# Install and setup poetry
RUN pip install -U pip \
  && apt-get update \
  && apt install -y curl netcat \
  && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python
ENV PATH="${PATH}:/root/.poetry/bin"

# WORKDIR /usr/src/app
COPY . .
# ADD main.py .
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi
# RUN pip install loguru lxml beautifulsoup4 requests

# run entrypoint.sh
# ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
CMD [ "python", "./main.py" ]
