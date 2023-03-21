FROM ubuntu:latest
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

#update OS and install python/gunicorn/nginx
#RUN apt-get update && \
#    apt-get install -y nginx gunicorn systemd wget python3.9 python3-pip vim
RUN apt-get update && \
apt-get install -y nginx gunicorn systemd curl python3.9 python3-pip vim

#copy requirement file and install python packages on global level
COPY requirements.txt ./
RUN pip install -r requirements.txt


#create directory for non-root user (app)
RUN mkdir -p /opt/app
#folder for pip
RUN mkdir -p /opt/.local
RUN mkdir -p /opt/.cache/pip

#create the app user
RUN addgroup --system app && adduser --system --group app
#change app user UID to 1000 to match volume mounted
RUN usermod -u 1000 app

#create appropriate directories
ENV HOME=/opt
ENV APP_HOME=/opt/app
ENV PIP_HOME=/opt/.local
WORKDIR $APP_HOME

#chown all files to the app user
RUN chown -R app:app $APP_HOME
RUN chown -R app:app $PIP_HOME
RUN chown -R app:app /opt/.cache

#change to app user
USER app
#copy required files to docker image
COPY get-pip.py ./
#install pip as user 
RUN python3 get-pip.py --user
#set python PATH
ENV PYTHONPATH /opt/.local/bin


#CMD gunicorn --bind 0.0.0:80 wsgi:app 


# ## KIV ##
# #install python3.9
# # install dependencies
# RUN apt update
# RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev liblzma-dev git python3-pip

# # download and compile openssl
# RUN curl -L https://www.openssl.org/source/openssl-1.1.1q.tar.gz | (cd /usr/src; tar xz)
# RUN cd /usr/src/openssl-1.1.1q && ./config --prefix=/usr/local && make -j4 && make install

# # download and configure pyenv
# RUN curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

# RUN echo >> ~/.bashrc # add new-line.
# RUN echo 'export PATH="/root/.pyenv/bin:$PATH"' >> ~/.bashrc
# RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
# RUN echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc 
# CMD source ~/.bashrc

# # build python 3.9.13 with pyenv
# CMD CONFIGURE_OPTS="--with-openssl=/usr/local --with-openssl-rpath=auto" pyenv install 3.9.13

# # build python 3.10.5 with pyenv
# # RUN CONFIGURE_OPTS="--with-openssl=/usr/local --with-openssl-rpath=auto" pyenv install 3.10.5
