# Use an HAProxy base image
FROM haproxy:latest

# Switch to root user for package installation
USER root

# Install PostgreSQL and other necessary packages
RUN apt-get update && apt-get install -y postgresql-client

# copy bash file to the iamge
COPY standby-check.sh /opt/services/postgres/standby-check.sh
COPY primary-check.sh /opt/services/postgres/primary-check.sh

# Set permissions to 777 for your two files
RUN chmod 777 /opt/services/postgres/primary-check.sh  && chmod 777  /opt/services/postgres/standby-check.sh
