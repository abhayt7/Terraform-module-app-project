module "dev_infra" {
    source = "./infra-app"
    env = "dev"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 1
    instance_type = "t2.micro"
    ec2_ami_id = "ami-084568db4383264d4"
    hash_key = "studentID"
}

module "prd_infra" {
    source = "./infra-app"
    env = "prd"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 2
    instance_type = "t2.micro"
    ec2_ami_id = "ami-084568db4383264d4"
    hash_key = "studentID"
}

module "stg_infra" {
    source = "./infra-app"
    env = "stg"
    bucket_name = "tws-infra-app-bucket"
    instance_count = 2
    instance_type = "t2.micro"
    ec2_ami_id = "ami-084568db4383264d4"
    hash_key = "studentID"
}