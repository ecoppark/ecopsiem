# Use a base image
FROM ubuntu:latest

# Install SSH server, UFW
RUN apt-get update && \
    apt-get install -y openssh-server ufw && \
    apt-get clean

# Configure SSH server
RUN mkdir /var/run/sshd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

# Set root password (change 'yourpassword' to your desired password)
RUN echo 'root:zxc123456' | chpasswd

# Copy HTML files to the web server directory
COPY ./ecopsiem/ /var/lib/ecopsiem/

# Expose ports
EXPOSE 22

# Start SSH and Apache services
CMD ["/usr/sbin/sshd", "-D"]