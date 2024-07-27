############notes:
#About provider: it tells about whose going to manage resource.
#In Terraform, the provider block specifies the provider you are using to interact with the resources. For Kubernetes, the provider block specifies how Terraform connects to your Kubernetes cluster.
#
#Explanation of the Kubernetes Provider Block
#provider "kubernetes":
#
#hcl
#Copy code
#provider "kubernetes" {
#config_path = "~/.kube/config"
#}
#provider "kubernetes": This tells Terraform that you are using the Kubernetes provider to manage Kubernetes resources.
#
#config_path: This specifies the path to your Kubernetes configuration file. The default location is usually ~/.kube/config, which is the standard location where kubectl stores the configuration for accessing your Kubernetes cluster. This file contains the credentials and cluster information necessary to connect to the Kubernetes API server.
#
#Different Providers and Their Configuration
#The configuration for different Terraform providers varies based on the provider and what it manages. Here’s a brief overview of how configurations differ between providers:
#
#1. AWS Provider
#Configuration Example:
#
#hcl
#Copy code
#provider "aws" {
#region = "us-west-2"
#access_key = "your_access_key"  # Optional, if not using IAM roles
#secret_key = "your_secret_key"  # Optional, if not using IAM roles
#}
#region: Specifies the AWS region where resources will be created.
#access_key and secret_key: Optional AWS credentials if not using environment variables or IAM roles.
#2. Azure Provider
#Configuration Example:
#
#hcl
#Copy code
#provider "azurerm" {
#features {}
#tenant_id       = "your_tenant_id"
#client_id       = "your_client_id"
#client_secret   = "your_client_secret"
#subscription_id = "your_subscription_id"
#}
#tenant_id: Azure Active Directory tenant ID.
#client_id and client_secret: Service principal credentials.
#subscription_id: Azure subscription ID.
#3. Google Cloud Provider
#Configuration Example:
#
#hcl
#Copy code
#provider "google" {
#credentials = file("<PATH_TO_JSON_KEY>")  # Path to JSON key file for authentication
#project     = "your_project_id"
#region      = "us-central1"
#}
#credentials: Path to the JSON key file for Google Cloud service account.
#project: Google Cloud project ID.
#region: Default region for resources.
#4. Kubernetes Provider
#Configuration Example:
#
#hcl
#Copy code
#provider "kubernetes" {
#config_path = "~/.kube/config"
#}
#config_path: Path to the Kubernetes configuration file for accessing the cluster.
#Summary
#AWS Provider: Connects to AWS using region and optional credentials.
#Azure Provider: Connects to Azure using tenant ID, client ID, and client secret.
#Google Cloud Provider: Connects to Google Cloud using a JSON key file and project ID.
#Kubernetes Provider: Connects to a Kubernetes cluster using the kubeconfig file.
#Each provider has specific configuration options suited to its platform, allowing Terraform to manage resources effectively across different environments.
provider "aws" {
  region = "us-east-1"  # Set your desired region
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}
#This configuration assumes that your Kubernetes configuration file is located at ~/.kube/config,
#which is the default location for Minikube and kind.

