FROM centos:8

RUN dnf update -y
RUN mkdir -p /tmp/working && cd /tmp/working

# Yum install basic packages
RUN dnf install -y \
      wget \
      zip \
      gcc \
      unzip \
      make \
      openssl-devel \
      gcc-c++ \
      epel-release

# Install and configure python3 and pip
RUN dnf install -y python3-pip && \
    echo "------------------ PIP Successfully Installed ------------------"

# Install eksctl
RUN mkdir -p /var/lib/eksctl && \
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /var/lib/eksctl && \
    /var/lib/eksctl/eksctl version && \
    echo "------------------ eksctl Successfully Installed ------------------"

ENV PATH="/var/lib/eksctl:/root/bin:${PATH}"

# Install kubectl
RUN mkdir -p /var/lib/kubectl && \
    curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl && \
    mv ./kubectl /var/lib/kubectl/kubectl && \
    chmod +x /var/lib/kubectl/kubectl && \
    /var/lib/kubectl/kubectl version --short --client

ENV PATH="/var/lib/kubectl:/root/bin:${PATH}"

# Install aws-iam-authenticator
RUN mkdir -p /var/lib/aws-iam-authenticator && \
    curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator && \
    mv ./aws-iam-authenticator /var/lib/aws-iam-authenticator/aws-iam-authenticator && \
    chmod +x /var/lib/aws-iam-authenticator/aws-iam-authenticator && \
    /var/lib/aws-iam-authenticator/aws-iam-authenticator help

ENV PATH="/var/lib/aws-iam-authenticator:/root/bin:${PATH}"

RUN dnf clean all

# User
RUN adduser developer
RUN mkdir /source-code && chown -R developer:developer /source-code
WORKDIR /home/developer

USER developer

# Install and configure aws cli
RUN pip3 install --user awscli --upgrade && \
    echo "------------------ AWS CLI Successfully Installed ------------------"

COPY pipeline.pem /home/.ssh/private-key
