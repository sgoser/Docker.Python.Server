FROM python:3.11-slim

LABEL maintainer="sgoser@gmail.com"

#RUN useradd -m pywebuser

WORKDIR /home/pywebuser/webserver

COPY index.html ./
COPY server.py ./

EXPOSE 8000

#USER pywebuser

ENTRYPOINT ["python", "server.py"]
