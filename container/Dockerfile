### Base Container
FROM ubuntu:latest AS base
LABEL maintainer="daemonchild"

# Creating new group, user && adding permission 
RUN groupadd -r burpsuite && useradd -r -g burpsuite collab

# Base installation
RUN apt-get update &&            \
        DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openjdk-25-jdk \
        openjdk-25-jre \
        curl

# Installation Cleanup
RUN apt-get autoremove && apt-get clean && /bin/rm -rf /var/lib/apt/lists/*

### Builder Container
FROM base AS builder

# Download Burpsuite
RUN curl -o /tmp/burppro.jar 'https://portswigger.net/burp/releases/download?product=pro&version=2026.1.5&type=Jar'

# Copy Config file and certs
COPY --chown=collab:burpsuite burpsuite/ /opt/burpsuite/


### Final Container

FROM base AS final

# Deploy BurpSuite Pro
COPY --from=builder /tmp/burppro.jar /opt/burpsuite/burppro.jar
COPY --from=builder --chmod=755 /opt/burpsuite/* /opt/burpsuite/

# This is the Production Image
FROM final AS production

# Set WORKDIR
WORKDIR /opt/burpsuite/

# Set USER
USER collab

# Docker Entrypoint
ENTRYPOINT ["/opt/burpsuite/entrypoint.sh"]
#CMD ["bash"]

