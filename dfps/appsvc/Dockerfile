FROM ibm-was:latest
MAINTAINER Michael Werle <Michael.Werle@dfps.state.tx.us>

USER wasadmin

ARG PROFILE_NAME=appsvc_profile
ARG CELL_NAME=cell1
ARG NODE_NAME=appsvcnode1
ARG HOST_NAME=appsvc

# TODO: Make variables for username/password
# TODO: Consider using a pssword file: https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.installation.base.doc/ae/cins_WASv85_base_install_Win32.html

RUN /apps/ibm/websphere/v855/bin/manageprofiles.sh -create \
        -profileName ${PROFILE_NAME} \
        -profilePath /apps/ibm/websphere/v855/profiles/${PROFILE_NAME} \
        -templatePath /apps/ibm/websphere/v855/profileTemplates/default \
        -cellName ${CELL_NAME} \
        -nodeName ${NODE_NAME} \
        -hostName ${HOST_NAME} \
        -isDefault \
        -defaultPorts && \
    /apps/ibm/websphere/v855/bin/managesdk.sh \
        -enableProfile \
        -sdkName 1.7_64 \
        -profileName ${PROFILE_NAME} \
        -enableServers

CMD ["/bin/bash"]
