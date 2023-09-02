# Start from an Ubuntu base image
FROM ubuntu:latest

# Environment variables for AWS credentials which need to be set ideally outside the Dockerfile
# ENV AWS_ACCESS_KEY_ID=<YOUR_ACCESS_KEY_ID>
# ENV AWS_SECRET_ACCESS_KEY=<YOUR_SECRET_ACCESS_KEY>
# ENV AWS_DEFAULT_REGION=<YOUR_REGION>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

# Install required packages for Terraform
RUN apt-get install -y curl gnupg software-properties-common vim sudo zip && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y terraform

# Install the AWS CLI using apt-get
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    apt-get install -y groff less && \
    sudo ./aws/install

# Set the working directory to /app
WORKDIR /app

# the command to run when the container starts
CMD ["terraform", "--version" && "aws", "--version"]

