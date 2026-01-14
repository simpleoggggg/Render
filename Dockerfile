FROM ubuntu:22.04

# Install tmate and dependencies
RUN apt-get update && \
    apt-get install -y tmate openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set root password (though tmate uses its own keys/session links)
RUN echo 'root:DXF!@#1014..' | chpasswd

# Tmate uses outgoing connections to its servers, 
# so usually no EXPOSE ports are required unless you run a local tmate-slave.
# However, we'll keep it clean.

# Start tmate in "foreground" mode and print the connection details to logs
CMD ["tmate", "-F"]
