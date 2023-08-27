FROM public.ecr.aws/docker/library/mongo:latest

#installing dependencies
RUN apt-get update
RUN apt-get install -y python3
RUN apt install curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN pip3 install awscliv2

WORKDIR /opt/backup/

#making directory to store custom scripts
WORKDIR /usr/src/scripts

#backup scripts
COPY backup.sh .
RUN chmod +x backup.sh

#restore scripts
COPY restore.sh .
RUN chmod +x restore.sh