# awscli-terraform-image - README.md

This is a repository for a Docker image with the AWS Command Line Interface (CLI) and latest version of Terraform available in the Alpine Linux package repository installed.

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)
[![Bandit](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/bandit.yml/badge.svg)](https://github.com/tom-halpin/awscli-terraform-image/actions/new?category=security)
[![Super-Linter](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)
[![Markdown Links Check](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/md-links.yml/badge.svg)](https://github.com/gaurav-nelson/github-action-markdown-link-check)
[![Spell-Checker](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/spellcheck.yaml/badge.svg)](https://github.com/rojopolis/spellcheck-github-actions)
[![Docker-Build-Push](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/docker-build-push.yml/badge.svg)](https://hub.docker.com/)
[![Docker-Push-README](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/docker-push-readme.yml/badge.svg)](https://hub.docker.com/)

In summary, this Dockerfile starts with the latest Alpine base image, installs the required packages for Terraform & the awscli, installs Terraform and the awscli and then sets the working directory to /app.

## Instructions

To use:

- Clone the repository

- Create two GitHub Action repository secrets ```DOCKERHUB_USERNAME``` & ```DOCKERHUB_PASSWORD```

- Add your Terraform scripts to repository

- Copy your Terraform scripts to app folder in the Dockerfile

- Build, deploy & use your image.

## To build and run an instance of a Docker image locally

### Build

Build the Docker image.

```bash
docker build -t awscli-terraform-image .
```

To verify build

```bash
docker image ls -a
```

### Run

Run the Docker image locally as a container.

In order to use the AWS provider in Terraform, you need to provide valid AWS access key, AWS secret key & AWS default region values via environment variables when running the Docker container, like so

```bash
    docker run -it -e AWS_ACCESS_KEY_ID=<access_key> -e AWS_SECRET_ACCESS_KEY=<secret_key> -e AWS_DEFAULT_REGION=<default region> awscli-terraform-image
```

This will start a new container and drop you into a Bash shell inside it. From there, you can navigate to the /app directory and run Terraform commands manually. For example, you can run ```terraform init``` by entering the command ```terraform init``` at the shell prompt.

## To pull and run an instance of the Docker image from Docker Hub

### Pull

```shell
docker pull tomhalpin/awscli-terraform-image:latest
```

**Note:** Replace <dockerhub-username> with your Docker Hub username and <tag> with the specific tag of the Docker image you want to pull.

### Run

```bash
docker run -it -e AWS_ACCESS_KEY_ID=<access_key> -e AWS_SECRET_ACCESS_KEY=<secret_key> -e AWS_DEFAULT_REGION=<default region> tomhalpin/awscli-terraform-image:latest
```

**Note:** Replace <dockerhub-username> with your Docker Hub username and <tag> with the specific tag of the Docker image you want to pull. You also need to provide valid AWS access key, AWS secret key & AWS default region values via environment variables when running the Docker container

## Commands

Following basic commands are examples of what can be run in the container. Of course it is possible to add custom Terraform scripts to the image and run them.

**Note:** It is very important to run ```terraform destroy``` while the container instance is running otherwise the Terraform state will be lost if the container is stopped. If the Terraform state is lost you will have to manually identify and delete resources created from the container.

```bash
terraform --version
aws --version

terraform init
terraform validate
terraform plan

terraform apply -> yes
terraform apply -auto-approve

aws ec2 describe-instances

terraform destroy -> yes
terraform destroy -auto-approve

aws ec2 describe-instances

exit
```
