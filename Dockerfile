FROM jboss/base-jdk:8

ARG EAP_ZIP
ARG EAP_FOLDER
ARG EAP_HTTP_LOCATION

RUN cd /opt/jboss/ && \
    curl -O $EAP_HTTP_LOCATION/$EAP_ZIP && \
    unzip $EAP_ZIP -d /opt/jboss/ && \
    ln -s /opt/jboss/$EAP_FOLDER eap && \
    rm -rf $EAP_ZIP && \
    rm -rf /opt/jboss/eap/quickstarts

RUN /opt/jboss/eap/bin/add-user.sh admin admin.123 --silent

ENV LAUNCH_JBOSS_IN_BACKGROUND true

EXPOSE 8080 9990

VOLUME /opt/jboss/eap/standalone/log
VOLUME /opt/jboss/eap/standalone/deployments

CMD ["/opt/jboss/eap/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
