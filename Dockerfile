FROM python:3.7.4-alpine3.10
RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
    apk add --no-cache --update python3 && \
    pip3 install --upgrade pip setuptools
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk add --no-cache mariadb-dev \
    && apk add busybox-extras

RUN apk add mysql mysql-client
RUN apk add --no-cache bash
RUN apk del build-deps
RUN mkdir /app
WORKDIR /app
RUN pip install PyMySQL
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY . .
 
EXPOSE 5000

CMD ["python", "app.py"]
