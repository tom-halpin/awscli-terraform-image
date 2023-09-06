# Start from an Alpine Linux base image
FROM alpine:latest

# Environment variables for AWS credentials which need to be set ideally outside the Dockerfile
# ENV AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
# ENV AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
# ENV AWS_DEFAULT_REGION=<YOUR_REGION>

# Update and install required packages for Terraform
RUN apk update && \
    apk add --no-cache curl gnupg vim sudo zip && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --import - && \
    apk del gnupg && \
    apk add --no-cache --virtual .build-deps \
        bash \
        && \
    apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community \
        terraform \
        && \
    apk del .build-deps

# install AWS CLI using pip, other methods didn't work
RUN apk add --update \
    py-pip \
    && pip install awscli --upgrade --user \
    && rm -rf /var/cache/apk/*

# Add AWS CLI binary directory to PATH for interactive use
ENV PATH="/root/.local/bin:$PATH"

# Set the working directory to /app
WORKDIR /app

# Define the command to run when the container starts
CMD ["sh", "-c", "echo 'Remember: It is very important to run 'terraform destroy' before exiting the container instance to ensure the Terraform state is not lost.!' && echo '' && terraform --version && echo '' && aws --version && /bin/sh"]

