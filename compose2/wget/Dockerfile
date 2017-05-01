FROM ubuntu

ARG file_path

RUN apt-get update && apt-get install -y wget iputils-ping
COPY file.txt ${file_path}/file.txt
RUN cat /etc/hosts


CMD tail -f /dev/null

