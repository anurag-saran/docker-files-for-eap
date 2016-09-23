FROM jboss/base-jdk:8
MAINTAINER Anurag Saran <asaran@redhat.com>

ENV INSTALLERS_DIR /opt/jboss/installers
ENV SUPPORT_DIR /opt/jboss/support
ENV JBOSS_HOME /opt/jboss/eap

#Copy files
ADD installers/ $INSTALLERS_DIR
ADD support/ $SUPPORT_DIR
USER root
RUN chown -R jboss:jboss $INSTALLERS_DIR $SUPPORT_DIR
USER jboss

#Prepare install files with JBOSS_HOME
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$JBOSS_HOME</installpath>:" $SUPPORT_DIR/eap.xml

#Install EAP
RUN java -jar $INSTALLERS_DIR/jboss-eap-6.4.0-installer.jar $SUPPORT_DIR/eap.xml -variablefile $SUPPORT_DIR/eap.xml.variables

#Patch EAP
WORKDIR $JBOSS_HOME
#RUN bin/standalone.sh --admin-only 2>&1 > /dev/null & sleep 4 && bin/jboss-cli.sh -c "patch apply $INSTALLERS_DIR/jboss-eap-6.4.9-patch.zip,shutdown"
#RUN bin/standalone.sh --admin-only 2>&1 > /dev/null & sleep 4 && bin/jboss-cli.sh -c "patch apply $INSTALLERS_DIR/jboss-eap-6.4.10-patch.zip,shutdown"

#Install default profiles
ADD default_profiles/ $JBOSS_HOME/standalone/configuration

#Install default maven configuration
ADD default_maven/ $HOME/.m2

#Install custom profiles and modules
ONBUILD ADD configuration/ $JBOSS_HOME/standalone/configuration
ONBUILD ADD modules/ $JBOSS_HOME/modules
ONBUILD ADD maven/ $HOME/.m2

#Launch configuration
WORKDIR $JBOSS_HOME
ENV LAUNCH_JBOSS_IN_BACKGROUND true
ENTRYPOINT ["bin/standalone.sh", "-c"]
CMD ["standalone.xml"]
