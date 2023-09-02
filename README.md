# awscli-terraform-image - README.md

This is a repository for a Docker image with the the AWS Command Line Interface (CLI) and Terraform installed.

[![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-brightgreen.svg)](https://opensource.org/licenses/MPL-2.0)
[![Bandit](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/bandit.yml/badge.svg)](https://github.com/tom-halpin/awscli-terraform-image/actions/new?category=security)
[![Super-Linter](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/linter.yml/badge.svg)](https://github.com/marketplace/actions/super-linter)
[![CodeQL](https://github.com/tom-halpin/awscli-terraform-image/workflows/CodeQL/badge.svg?branch=main)
[![Markdown Links Check](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/md-links.yml/badge.svg)](https://github.com/gaurav-nelson/github-action-markdown-link-check)
[![Spell-Checker](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/spellcheck.yaml/badge.svg)](https://github.com/rojopolis/spellcheck-github-actions)
[![Docker-Build-Push](https://github.com/tom-halpin/awscli-terraform-image/actions/workflows/docker-build-push.yml/badge.svg)](https://hub.docker.com/)

In summary, this Dockerfile starts with the Ubuntu 20.04 base image, installs the required packages for Terraform & the awscli, installs Terraform and the awscli and sets the working directory to /app.

## To build and run an instance of a Docker image locally.

### Build

Build the Docker image.

```shell
docker build -t awscli-terraform-image .
```

To verify build

```shell
docker image ls -a
```

### Run

Run the Docker image as a container.

```shell
docker run -it awscli-terraform-image
```
## To pull and run an instance of the Docker image from Docker Hub

### Pull

```shell
docker pull <dockerhub-username>/awscli-terraform-image:<tag>
```

**Note:** Replace <dockerhub-username> with your Docker Hub username and <tag> with the specific tag of the Docker image you want to pull.

### Run

```shell
docker run -it <dockerhub-username>/awscli-terraform-image:<tag>
```

**Note:** Replace <dockerhub-username> with your Docker Hub username and <tag> with the specific tag of the Docker image you want to pull.

This will start a new container and drop you into a Bash shell inside it. From there, you can navigate to the /app directory and run Terraform commands manually. For example, you can run ```terraform init`````` by entering the command ```terraform init``` at the shell prompt.

#### AWS Credentials

In order to use the AWS provider in Terraform, you need to provide valid AWS access key, AWS secret key & AWS default region via environment variables when running the Docker container, like so

```bash
    docker run -it -e AWS_ACCESS_KEY_ID=<access_key> -e AWS_SECRET_ACCESS_KEY=<secret_key> -e AWS_DEFAULT_REGION=<default region> awscli-terraform-image /bin/bash
```

#### Commands

Following commands are to be run in the container.

**Note:** It is very important to run ```terraform destroy``` whilst container instance is running otherwise terraform state will not be known. Hence will have to manually identify and delete resources created from the container.

```bash
terraform --version
aws --version

terraform init
terraform validate
terraform plan

terraform apply -> yes
terraform apply -auto-approve

aws ec2 describe-instances

terraform destory -> yes
terraform destroy -auto-approve

aws ec2 describe-instances

exit
```
