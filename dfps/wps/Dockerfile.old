FROM ibm-was:latest
MAINTAINER Michael Werle <Michael.Werle@dfps.state.tx.us>

# All we really need to do is to add the scripts
ARG SCRIPTS_DIR=/install/scripts/wps
ADD /scripts ${SCRIPTS_DIR}

USER wasadmin

ARG IBM_REPOSITORY=http://172.17.0.2/repository.config
ARG INSTALL_RESPONSE_FILE=PortalResponseFile_docker_v1.2.xml
ARG WPS_PROFILE_NAME=wp_profile
ARG WPS_CELL_NAME=cell1
ARG WPS_NODE_NAME=webnode1
ARG WPS_HOST_NAME=web

# TODO: Make variables for username/password
# TODO: Consider using a pssword file: https://www.ibm.com/support/knowledgecenter/SSEQTP_8.5.5/com.ibm.websphere.installation.base.doc/ae/cins_WASv85_base_install_Win32.html

# This strange hack gets around hostname issues with websphere during the build
#    sed -i'' -r -e 's/127[.]0[.]0[.]1[^#]*/\0 web web.lab.ibm.com machine1 machine1.lab.ibm.com/' /tmp/hosts && \
# The odd sleeps are to ensure that all processes have exited before ending

RUN cp /etc/hosts /tmp/hosts && \
    echo "$(hostname -i) web machine1 web.lab.ibm.com machine1.lab.ibm.com" >> /tmp/hosts && \
    mkdir -p -- /tmp/lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /tmp/lib-override && \
    perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /tmp/lib-override/libnss_files.so.2 && \
    export LD_LIBRARY_PATH=/tmp/lib-override && \
    /apps/ibm/installationmanager/eclipse/tools/imcl \
        input ${SCRIPTS_DIR}/${INSTALL_RESPONSE_FILE} \
        -accessRights nonAdmin -acceptLicense \
        -variables repositoryLocation=${IBM_REPOSITORY},profileName=${WPS_PROFILE_NAME},cellName=${WPS_CELL_NAME},nodeName=${WPS_NODE_NAME},hostName=${WPS_HOST_NAME} \
        -log /apps/ibm/logs/${INSTALL_RESPONSE_FILE}.log \
        -showVerboseProgress \
        -dataLocation /apps/ibm/installationmanagerData && \
    sleep 10 && \
    /apps/ibm/websphere/v855/profiles/wp_profile/bin/stopServer.sh WebSphere_Portal \
        -username wpsadmin -password wpsadmin && \
    sleep 10 && \
    rm -rf /tmp/hosts /tmp/lib-override

ARG FIXPACK_RESPONSE_FILE=Portal85CF7Fixpack_docker.xml

RUN cp /etc/hosts /tmp/hosts && \
    echo "$(hostname -i) web machine1 web.lab.ibm.com machine1.lab.ibm.com" >> /tmp/hosts && \
    mkdir -p -- /tmp/lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /tmp/lib-override && \
    perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /tmp/lib-override/libnss_files.so.2 && \
    export LD_LIBRARY_PATH=/tmp/lib-override && \
    /apps/ibm/installationmanager/eclipse/tools/imcl \
        input ${SCRIPTS_DIR}/${FIXPACK_RESPONSE_FILE} \
        -accessRights nonAdmin -acceptLicense \
        -variables repositoryLocation=${IBM_REPOSITORY},profileName=${WPS_PROFILE_NAME},cellName=${WPS_CELL_NAME},nodeName=${WPS_NODE_NAME},hostName=${WPS_HOST_NAME} \
        -log /apps/ibm/logs/${FIXPACK_RESPONSE_FILE}.log \
        -showVerboseProgress \
        -dataLocation /apps/ibm/installationmanagerData && \
    rm -rf /tmp/hosts /tmp/lib-override

RUN cp /etc/hosts /tmp/hosts && \
    echo "$(hostname -i) web machine1 web.lab.ibm.com machine1.lab.ibm.com" >> /tmp/hosts && \
    mkdir -p -- /tmp/lib-override && cp /lib/x86_64-linux-gnu/libnss_files.so.2 /tmp/lib-override && \
    perl -pi -e 's:/etc/hosts:/tmp/hosts:g' /tmp/lib-override/libnss_files.so.2 && \
    export LD_LIBRARY_PATH=/tmp/lib-override && \
    /apps/ibm/websphere/v855/profiles/wp_profile/ConfigEngine/ConfigEngine.sh PRE-APPLY-FIX && \
    /apps/ibm/websphere/v855/profiles/wp_profile/ConfigEngine/ConfigEngine.sh APPLY-FIX \
        -DPortalAdminPwd=wpsadmin -DWasPassword=wpsadmin && \
    /apps/ibm/websphere/v855/profiles/wp_profile/bin/stopServer.sh WebSphere_Portal \
        -username wpsadmin -password wpsadmin && \
    rm -rf /tmp/hosts /tmp/lib-override

CMD cd /apps/ibm/websphere/v855/profiles/wp_profile/bin && ./startServer.sh WebSphere_Portal && tail -f /dev/null

EXPOSE 10032-10047
