FROM ubuntu:trusty
MAINTAINER Michael Werle <Michael.Werle@dfps.state.tx.us>

ARG GROUP_NAME=wasadmin
ARG GROUP_ID=225
ARG USER_NAME=wasadmin
ARG USER_ID=225
# "wasadmin"
ARG USER_PASSWORD=yEh6wu/lviwu6

# Update and install less and lsof becuase they are useful, and nfs-common so we can mount installers
# /bin/sh is dash, not bash, by default
# Users and groups for websphere
# Ownership of the install directory
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX && \
    ln -sfn /bin/bash /bin/sh && \
    groupadd -g ${GROUP_ID} ${GROUP_NAME} && \
    useradd -c 'WebSphere' -d /apps/ibm -g ${GROUP_NAME} -M -N -p ${yUSER_PASSWORD} -r \
        -u ${USER_ID} ${USER_NAME} && \
    mkdir -p /apps/ibm && chown ${USER_NAME}:${GROUP_NAME} /apps/ibm && \
    echo 'wasadmin	ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'Defaults:wasadmin	!requiretty' >> /etc/sudoers
