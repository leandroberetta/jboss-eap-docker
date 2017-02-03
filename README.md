# jboss-eap-docker

This project provides a Dockerfile for generate a JBoss EAP Docker image.

## Usage

It can be any official JBoss EAP 6.X downloaded from Red Hat. The Dockerfile allows the configuration of an specific EAP version with the following variables:

* **EAP_ZIP** -> Name of the ZIP file
* **EAP_FOLDER** -> Name of the uncompressed folder
* **EAP_HTTP_LOCATION** -> Any server to download the image

If the ZIP file is local, it can be served with the Python simple http server executing the following commmand in the folder where the ZIP is:

    python -m SimpleHTTPServer 8000

Review the Dockerfile to see the ports and volumes available to use.

The default user is admin with admin.123 as the password. It is possible to configure this from the outside (See the examples below).

## Docker build example

    docker build --build-arg EAP_ZIP=jboss-eap-6.4.0.zip --build-arg EAP_FOLDER=jboss-eap-6.4 --build-arg EAP_HTTP_LOCATION=<IP>:8000 -t=redhat/eap:6.4 .

## Docker run example

    # Interactive mode
    docker run -it redhat/eap:6.4 /bin/bash

    # With port bindings and with logs outside the container
    docker run --name eap -d -p 8080:8080 -p 9990:9990 -v /path/to/eap/logs/:/opt/jboss/eap/standalone/log redhat/eap:6.4

    # With custom standalone.xml (using a volume to mount a file directly, not a folder!)
    docker run --name eap -d -p 8080:8080 -p 9990:9990 -v /path/to/eap/logs/:/opt/jboss/eap/standalone/log -v /path/to/eap/standalone/configuration/custom-standalone.xml:/opt/jboss/eap/standalone/configuration/standalone.xml redhat/eap:6.4

    # With custom user and password (using a volume to mount a file directly, not a folder!)
    docker run --name eap -d -p 8080:8080 -p 9990:9990 -v /path/to/eap/logs/:/opt/jboss/eap/standalone/log -v /path/to/eap/standalone/configuration/mgmt-users.properties:/opt/jboss/eap/standalone/configuration/mgmt-users.properties redhat/eap:6.4
