FROM ubuntu:18.04

# User Name
ARG USERNAME=yoichiro6642

# Install Dependencies
RUN apt-get update && \
    apt-get install -y wget curl git

# Install Go
RUN curl -O https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz && \
    tar xvf go1.10.3.linux-amd64.tar.gz && \
    chown -R root:root ./go && \
    mv ./go /usr/local

# Add a new user
RUN groupadd --gid 1000 $USERNAME && useradd -u 1000 -g 1000 -s /bin/bash -d /home/$USERNAME -m $USERNAME
USER $USERNAME

WORKDIR /home/$USERNAME

# Set the configuration for Go
RUN mkdir /home/$USERNAME/go && \
    echo "export GOPATH=\$HOME/go" >> /home/$USERNAME/.bashrc && \
    echo "export PATH=\$PATH:\$GOPATH/bin:/usr/local/go/bin" >> /home/$USERNAME/.bashrc

RUN /usr/local/go/bin/go get github.com/googlecodelabs/tools/claat

# Prepare working directory
WORKDIR /home/$USERNAME/project

VOLUME /home/$USERNAME/project

CMD ["/bin/bash"]
