FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

#create directory for non-root user (app)
RUN mkdir -p /opt/app

#create the app user
RUN addgroup --system app && adduser --system --group app

#create appropriate directories
ENV HOME=/opt
ENV APP_HOME=/opt/app
#RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update && apt-get upgrade -y \
    nano python3-pip python3-dev nginx gunicorn systemd

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

#copy from local
#COPY . $APP_HOME

#chown all files to the app user
RUN chown -R app:app $APP_HOME

#change to app user
USER app

#CMD gunicorn --bind 0.0.0:80 wsgi:app 

