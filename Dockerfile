FROM public.ecr.aws/docker/library/mongo:latest

#installing dependencies
RUN apt-get update
RUN apt install awscli -y
RUN apt install wget -y
RUN apt install util-linux -y

#installing s3 mountpoint binary
RUN wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.deb
RUN apt-get install ./mount-s3.deb -y

#making directory to store custom scripts
WORKDIR /usr/src/scripts

#backup scripts
COPY backup.sh .
RUN chmod +x backup.sh

#restore scripts
COPY restore.sh .
RUN chmod +x restore.sh