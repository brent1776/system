FROM ibm-base
MAINTAINER Michael Werle <Michael.Werle@dfps.state.tx.us>

ARG APACHE_IM_HOST=172.17.0.2

USER wasadmin

RUN sudo apt-get update && sudo apt-get install -y wget 
RUN sudo mkdir -p /install/IM64 && \
    sudo wget -q -O- http://${APACHE_IM_HOST}/IM64.tgz | ( cd /install/IM64; sudo tar -zxf - ) && \
    sudo chown -R wasadmin /install && sudo chmod -R 775 /install && \
    ls -Rl /install && \
    /install/IM64/tools/imcl install com.ibm.cic.agent \
        -accessRights nonAdmin -acceptLicense \
        -installationDirectory /apps/ibm/installationmanager \
        -dataLocation /apps/ibm/installationmanagerData \
        -sharedResourcesDirectory /apps/ibm/installationmanager/imshared \
        -repositories /install/IM64/repository.config -showVerboseProgress \
        -preferences com.ibm.cic.common.core.preferences.preserveDownloadedArtifacts=false,com.ibm.cic.common.core.preferences.keepFetchedFiles=false \
        -log /apps/ibm/logs/IMSilentInstall.log && \
    sudo rm -rf /install/IM64

CMD ["/bin/bash"]
