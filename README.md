# Terraform NGINX Lab

This is a beginner-level Terraform lab that uses the Docker provider to deploy an NGINX container to a remote Ubuntu server (headless Mac) over SSH.

## Tech Stack

- Terraform
- Docker
- NGINX
- Ubuntu 22.04
- SSH-based Docker provider

## Local Exposure

The NGINX container maps port 80 → 8080 on the host: http://your_host_ip:8080

## Terraform Commands

```bash
terraform init      # Setup Terraform provider
terraform plan      # Preview changes
terraform apply     # Deploy container
terraform destroy   # Remove container

## Project Structure

├── provider.tf # Docker provider using SSH to remote Ubuntu host
├── main.tf # NGINX container definition and port mapping
├── .gitignore # Terraform and VS Code exclusions
├── README.md # Project overview and usage

## Next Steps

- [ ] Add custom Python (Flask) app container
- [ ] Configure NGINX as reverse proxy to Flask
- [ ] Add Docker network to isolate containers
- [ ] Add PostgreSQL container and shared volume
- [ ] Migrate full stack to Azure using Terraform
