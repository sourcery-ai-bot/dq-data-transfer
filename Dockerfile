FROM python:3-slim

COPY . /data-transfer
WORKDIR /data-transfer
# setup dependencies
RUN apt-get update
RUN apt-get -y install curl xz-utils
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN pip3 install -e . -r requirements.txt
RUN npm install pm2 -g


# Create user and change folder permissions
RUN groupadd -r datatransfer && useradd -r -g datatransfer -u 1000 datatransfer && \
    chown -R datatransfer:datatransfer /data-transfer

USER 1000 

ENV PYTHONPATH /data-transfer

ENTRYPOINT [ "bin/data-transfer" ]
