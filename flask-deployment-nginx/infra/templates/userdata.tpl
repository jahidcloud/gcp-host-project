#!/bin/bash



repo_url=https://github.com/jahidcloud/gcp-host-project.git

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
apt-get install -y docker-compose

# Install Git
apt-get update
apt-get install -y git
cd
mkdir app-hosting
cd app-hosting
git clone $repo_url
