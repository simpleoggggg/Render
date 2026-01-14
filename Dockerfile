FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install tmate and Docker CLI
RUN apt-get update && \
    apt-get install -y tmate docker.io curl openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 2. Set root password (optional for tmate, but good for local use)
RUN echo 'root:DXF!@#1014..' | chpasswd

# 3. Startup script to show the Termius link and keep container alive
RUN echo '#!/bin/bash\n\
tmate -S /tmp/tmate.sock new-session -d\n\
tmate -S /tmp/tmate.sock wait tmate-ready\n\
echo "------------------------------------------"\n\
echo "--- COPY THIS SSH ADDRESS FOR TERMIUS ---"\n\
tmate -S /tmp/tmate.sock display -p "#{tmate_ssh}"\n\
echo "------------------------------------------"\n\
tail -f /dev/null' > /startup.sh && chmod +x /startup.sh

CMD ["/startup.sh"]
