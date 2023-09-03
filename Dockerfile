FROM public.ecr.aws/docker/library/mongo:latest

#installing dependencies
RUN apt-get update
RUN apt-get install -y awscli

WORKDIR /opt/backup/

#making directory to store custom scripts
WORKDIR /usr/src/scripts

#backup scripts
COPY backup.sh .
RUN chmod +x backup.sh

#restore scripts
COPY restore.sh .
RUN chmod +x restore.sh

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/apt/lists/*