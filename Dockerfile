# Start from an Alpine Linux base image
FROM alpine:latest

# Environment variables for AWS credentials which need to be set ideally outside the Dockerfile
# ENV AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
# ENV AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
# ENV AWS_DEFAULT_REGION=<YOUR_REGION>

# Update and install required packages for Terraform
# This will install the latest version of Terraform available in the Alpine Linux package repository
RUN apk update && \
    apk add --no-cache curl gnupg vim sudo zip && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --import - && \
    apk del gnupg && \
    apk add --no-cache --virtual bash && \
    apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community terraform

# install AWS CLI using pip, other methods didn't work
RUN apk add --update \
    py-pip \
    && pip install awscli --upgrade --user \
    && rm -rf /var/cache/apk/*

# Add AWS CLI binary directory to PATH for interactive use
ENV PATH="/root/.local/bin:$PATH"

# Set the working directory to /app
WORKDIR /app

COPY entrypoint.sh /entrypoint.sh

# Define the command to run when the container starts
CMD ["/bin/sh", "/entrypoint.sh"]