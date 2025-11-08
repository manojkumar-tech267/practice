module "vpc" {
    source = "git::https://github.com/manojkumar-tech267/interview-preparation.git//terraform/01-modules/modules/vpc?ref=main"
    project = "roboshop"
    environment = "dev"
    public_cidr_blocks = ["10.0.1.0/24","10.0.2.0/24"]
    private_cidr_blocks = ["10.0.11.0/24","10.0.12.0/24"]
    database_cidr_blocks = ["10.0.21.0/24","10.0.22.0/24"]
    is_peering_required = true
}