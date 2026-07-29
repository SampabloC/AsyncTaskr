# Deploying the Task API to AWS EC2

## Overview

This document describes the steps to deploy the Task API application to an AWS EC2 instance.

## Diagram

Internet
    │
    ▼
Nginx
    │
    ▼
Rails Container
    │
    ├── PostgreSQL
    └── Redis
          │
      Sidekiq

## Prerequisites

- An AWS account with EC2 access
- An existing EC2 instance or permissions to create one
- SSH access to the EC2 instance
- Docker installed on the instance
- The application container loaded on ECR service
- Key pair file
- An IAM Role created

## IAM Role

- The IAM user must have an acces key
- It is neccesary to have an IAM Role with the next policy
```bash
AmazonEC2ContainerRegistryReadOnly
```
- This policy allow us to pull the image into the EC2 instance

## Deployment Steps

1. Launch an EC2 instance
   - Select an Amazon Linux 2023
   - Choose an instance type (e.g. t3.micro for testing)
   - Configure security group to allow ports:
     - 22 for SSH
     - 80 or 443 for HTTP/HTTPS
     - any application-specific port (if not using a reverse proxy)
   - Assing IAM Role

2. Connect to the instance

```bash
ssh -i /path/to/key.pem ec2-user@<EC2_PUBLIC_IP>
```

3. Install dependencies

For Amazon Linux 2023:

```bash
sudo dnf update -y
```

4. Install Docker and Docker compose

- Install docker
```bash
sudo yum install -y docker
```
- Start the service
```bash
sudo systemctl start docker
sudo systemctl enable docker
```
- Add the user to docker group to run without sudo
```bash
sudo usermod -aG docker $USER
```
- Close SSH connection and reconnect to refresh user permissions

5. Copy the files into docker folder to start the application

- Copy the docker-compose.yml to the ec2 instance
```bash
scp deploy/docker-compose.yml ec2:app/
```

- Authenticate to AWS console to allow you to start the project
- Run the docker compose command to create and pull the images
```bash
docker compose pull
docker compose up -d
```

6. Set up the application
- Enter to docker container
```bash
docker exec -it <container_name> bash
```

- Set up database inside the container
```bash
bin/rails db:setup
```

- Verify the migrations
```bash
bin/rails db:migrate:status
```

- Run the migrations if needed
```bash
bin/rails db:migrate RAILS_ENV=production
```

7. Verify deployment

- Access the application via the EC2 public IP or domain
- Check logs and confirm the service is running

## Configure Nginx

1. Install Nginx if needed
```bash
sudo dnf install -y nginx
```

2. Start service and verify status
```bash
sudo systemctl start nginx
sudo systemctl status nginx
```

3. Create or copy the nginx conf file
```bash
scp deploy/nginx/async_taskr.conf ec2:/etc/nginx/conf.d/
sudo nano /etc/nginx/conf.d/async_taskr.conf
```

4. Verify nginx syntax is correct
```bash
sudo nginx -t
```

5. If needed, comment in /etc/nginx/nginx.conf the server block

## Notes

- Configure proper IAM roles, security groups, and backups.
- Add HTTPS with a load balancer or reverse proxy if needed.

## Troubleshooting

### ECR

> no matching manifest for linux/amd64

> user multiplatform buildx

### Browser

> HTTPS doesn't work

> Use HTTP until TLS is configured
