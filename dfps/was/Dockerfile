FROM ibm-im:latest
MAINTAINER Michael Werle <Michael.Werle@dfps.state.tx.us>

ARG SCRIPTS_DIR=/install/scripts/was
ADD /scripts ${SCRIPTS_DIR}

USER wasadmin

ARG IBM_REPOSITORY=http://172.17.0.2/repository.config
ARG INSTALL_RESPONSE_FILE=WasJdkResponseFile_docker_v1.2.xml

RUN /apps/ibm/installationmanager/eclipse/tools/imcl \
        input ${SCRIPTS_DIR}/${INSTALL_RESPONSE_FILE} \
        -accessRights nonAdmin -acceptLicense \
        -variables repositoryLocation=${IBM_REPOSITORY} \
        -log /apps/ibm/logs/${INSTALL_RESPONSE_FILE}.log \
        -showVerboseProgress \
        -dataLocation /apps/ibm/installationmanagerData

CMD ["/bin/bash"]
