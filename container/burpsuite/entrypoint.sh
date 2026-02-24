#!/bin/bash
cd /opt/burpsuite
exec java -jar /opt/burpsuite/burppro.jar --collaborator-server --collaborator-config=/opt/burpsuite/burp.config | tee burpcollaborator.logs