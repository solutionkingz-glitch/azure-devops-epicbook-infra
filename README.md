# EpicBook on Azure (1/2): Infrastructure

Terraform and an Azure DevOps pipeline that provision a three-tier Azure environment for the EpicBook application.

Companion repository (Ansible deployment): https://github.com/solutionkingz-glitch/azure-devops-epicbook-app

## Architecture

User -> Frontend VM (Nginx, port 80) -> Backend VM (EpicBook, port 8080) -> Azure Database for MySQL Flexible Server (port 3306, private access)

- Region: East US 2
- Separate subnets for frontend, backend and the delegated database tier
- Only the frontend accepts public HTTP traffic
- SSH on both VMs is restricted to an approved admin and agent IP
- The backend port 8080 is reachable only from the frontend subnet
- MySQL has no public endpoint and resolves through a private DNS zone

## Repository layout

- terraform/versions.tf, providers.tf, backend.tf: Terraform and provider versions, Azure Storage remote state
- terraform/network.tf: resource group, VNet, subnets, NSGs
- terraform/compute.tf: public IPs, NICs, frontend and backend Ubuntu 24.04 VMs
- terraform/database.tf: private DNS zone, VNet link, MySQL Flexible Server
- terraform/outputs.tf: non-sensitive outputs
- azure-pipelines.yml: infrastructure pipeline

## Pipeline

Stages: Validate, Plan, Apply, Outputs

1. Validate: init, fmt check, validate
2. Plan: saves a plan file and publishes it as an artifact (state is never published)
3. Apply: waits for manual approval in the epicbook-infra-prod environment, then applies the same reviewed plan
4. Outputs: prints app_public_ip, backend_ansible_host, backend_private_ip and mysql_fqdn

## Authentication and secrets

- Azure access: Azure Resource Manager service connection using an app registration with a client secret (stored only in the service connection)
- Terraform state: Azure Storage remote backend, accessed with Azure AD (no storage keys)
- MySQL credentials: Azure DevOps variable group, password marked secret
- The SSH public key is committed as a file (public keys are not secret); the private key lives only in Azure DevOps Secure Files
- No secrets, state files or private keys are stored in this repository

## Manual handoff to the application repository

After a successful apply, the four outputs are copied by hand into the Ansible inventory and group variables in the application repository. This could later be automated by publishing the outputs as a pipeline artifact or storing them in a variable group.

## Known lab trade-offs

- MySQL require_secure_transport is OFF because the app's Sequelize config has no SSL options. The server is private-only. Production should enable TLS with a CA bundle.
- The backend VM has a public management IP for Ansible. Production should use a private path such as a bastion or an in-VNet agent.
- The admin IP is written into the pipeline YAML and must be updated if the ISP changes it.
- Service principal has Contributor at subscription scope. Production should scope it more tightly or use workload identity federation.
