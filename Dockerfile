# Use Ubuntu 22.04 for a full-featured environment
FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install tmate and basic tools
RUN apt-get update && apt-get install -y \
    tmate \
    curl \
    wget \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Create a start script to launch tmate and print the SSH URL to logs
RUN echo '#!/bin/bash\n\
tmate -S /tmp/tmate.sock new-session -d\n\
tmate -S /tmp/tmate.sock wait tmate-ready\n\
echo "--- TMATE SSH CONNECTION INFO ---"\n\
tmate -S /tmp/tmate.sock display -p "#{tmate_ssh}"\n\
echo "---------------------------------"\n\
tail -f /dev/null' > /entrypoint.sh && chmod +x /entrypoint.sh

# Render requires a port to be exposed for Web Services
EXPOSE 10000

ENTRYPOINT ["/entrypoint.sh"]

