FROM jboss/base-jdk:8

# Change this line depending of the file name of RHAMT distribution
COPY migrationtoolkit-rhamt-cli-4.3.1.Final-offline.zip $HOME
RUN mv $HOME/migrationtoolkit-rhamt-cli-4.3.1.Final-offline.zip $HOME/rhamt-cli.zip

# Add the JBoss Windup distribution to /opt, and make windup the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
&& unzip rhamt-cli.zip \
&& mv $HOME/rhamt-cli-* $HOME/windup \
&& rm rhamt-cli.zip

# Set the WINDUP_HOME env variable
ENV WINDUP_HOME /opt/jboss/windup


# User root user to install software
USER root
RUN chown -R root:root /opt/jboss/windup


# Set the default command to run on boot
# This will boot the Windup CLI
CMD ["/opt/jboss/windup/bin/rhamt-cli"]
