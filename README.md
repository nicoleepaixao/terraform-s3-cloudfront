# Terraform S3 + CloudFront Setup

## The Problem

Setting up an S3 bucket and a CloudFront distribution manually can be time-consuming and error-prone. Every time we need to spin up the infrastructure, we spend up to **1 hour** creating the resources individually and reviewing configurations. Additionally, the chances of making mistakes are high, especially regarding permissions.

This project solves that problem by automating the creation and configuration of a **private S3 bucket** with **CloudFront**, ensuring **95% decrease in setup time**.

## How It Works

Using **Terraform**, this project provisions:

- A **private S3 bucket**, with controlled access permissions.
- A **CloudFront distribution** to serve files from the bucket.
- Automatic validation of **SSL certificates** to ensure traffic security.

## Structure

```plaintext
.
├── sua-bucket/                # Copy the files from the template folder here and modify terraform.tfvars
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars       # Modify this file with your specific bucket details
├── modulos/                   # Modules folder containing reusable Terraform modules
│   ├── s3_bucket/             # S3 configuration module
│   │   ├── main.tf            # S3 bucket provisioning code
│   └── cloudfront/            # CloudFront configuration module
│       ├── main.tf            # CloudFront provisioning code
└── template/                  # Template folder containing the main files
    ├── main.tf                # Main configuration file
    ├── variables.tf           # Input variables
    ├── outputs.tf             # Terraform outputs
    └── terraform.tfvars       # Template variables file to copy and modify for your bucket

```
## How to Use

1. Clone the repository:
    ```plaintext
      git clone https://github.com/nicoleepaixao/terraform-s3-cloudfront.git
      cd terraform-s3-cloudfront
    ```
2. Create a folder named after your S3 bucket:
    ```plaintext
      mkdir my-bucket-name
      cd my-bucket-name
    ```
3. Copy the necessary Terraform files into this folder and adjust the variables in the terraform.tfvars file.

4. Initialize Terraform:
    ```plaintext
      terraform init     # Initializes the project, downloads providers, and sets up the backend
      terraform plan     # Displays the changes that will be made to the infrastructure
      terraform apply    # Applies the changes and provisions the infrastructure
    ```

### Full Article on Medium
For more details about the problem we solved and how everything was set up, check out the article on Medium: [Automating AWS Infrastructure: S3 + CloudFront with Terraform](https://nicoleepaixao.medium.com/automating-aws-infrastructure-s3-cloudfront-with-terraform-fea7e792e2f5).
