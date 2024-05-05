# Overview

Terraform code for [blog post](https://gh40.net/posts/code-engine-rb) on deploying the [request-baskets](https://github.com/darklynx/request-baskets) application on IBM Cloud Code Engine.

![High-level overview](./ce-rb-diagram.png)

## Prerequisites

- [IBM Cloud API Key](https://cloud.ibm.com/registration)
- [Terraform installed locally](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## Getting started

### Clone the repository

First, clone the `request-baskets` terraform repository to your local machine:

    ```shell
    git clone https://github.com/cloud-design-dev/ibmcloud-tf-ce-request-baskets.git
    cd ibmcloud-tf-ce-request-baskets
    ```

### Set Terraform environment variables

Copy the `terraform.tfvars.example` file to `terraform.tfvars`, open it in a text editor and set the following variables:

- **ibmcloud_api_key**: Your IBM Cloud API key.
- **ibmcloud_region** - The IBM Cloud region where you want to deploy the resources. Default is `us-south`.
- **existing_resource_group** - The name of the resource group where you want to deploy the resources.
- **existing_postgres_instance** - The name of the existing PostgreSQL instance where you want to store the requests.
- **project_owner** - Owner to associate with the project. Will be used as a tag for the resources.

## Initialize Terraform

Run the `init` command to initialize Terraform in the directory and download the required providers and modules:

    ```shell
    terraform init
    ```

## Generate the Terraform plan

Run the following command to generate a Terraform plan and save it to the file `default.tfplan`:

    ```shell
    terraform plan -out default.tfplan
    ```

## Apply the Terraform plan

Run the following command to apply the Terraform plan, create our project, and deploy the application:

    ```shell
    terraform apply default.tfplan
    ```

The Code Engine project will take a few minutes to get created. Once the project is created, Terraform will move on to deploying our application using the `request-baskets` container image and add our PostgreSQL connection details to the running instance via environmental variables.

## Clean up

To clean up the resources created by Terraform, run the following command:

    ```shell
    terraform plan -destroy -out destroy.tfplan
    terraform apply destroy.tfplan
    ```

