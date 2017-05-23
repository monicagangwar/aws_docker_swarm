# AWS DOCKER SWARM SETUP

AWS Setup for launching Docker Swarm Cluster on 3 nodes (1 master, 2 workers)  
[Quick Demo](https://vimeo.com/218763304)


### Infrastructure
![image](https://cloud.githubusercontent.com/assets/8946358/26339554/5ff32374-3fa6-11e7-8f27-0da44dfb70d3.png)

### Dependencies
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)

### Configuration
- Create an IAM user and get `ACCESS KEY` & `SECRET ACCESS KEY` on [AWS CONSOLE](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console)
- Hit `aws configure` and add `ACCESS KEY` & `SECRET ACCESS KEY`
- Change the region and availability zone in `variables.tf` file if you wish to launch the setup in another region. Currently it defaults to us-east-1

### Usage
- Run init script which will create a S3 bucket for storing terraform remote state. Change the bucket name in [setup](setup/aws/terraform_state_s3_bucket.tf)
```
./init_aws.sh
```
- Launch global resources which contains ssh key. Change key path in [ssh_key.tf](global/ssh_key.tf)
```
cd global
terraform apply
```
- Lauch VPC. Change accordingly in [variables.tf](vpc/variables.tf)
```
cd vpc
terraform apply
```
- Launch Nodes. Change accordingly in [variables.tf](nodes/variables.tf)
```
cd nodes
terraform apply
```

### Output to Note
- `manager_ip`  
   * Its the IP of manager node which belongs to a swarm lanched on bootup of nodes.  
   * Services launched via Controller UI can pe accessed on `manager_ip:port_specified`
- `controller_ip`  
   * Controller has [Portainer]() running on Port 9000 which is a UI over Docker Engine.  
   * Hit `controller_ip:9000` and login  
   * Enter `manager_ip:2375` when asked for Docker Endpoint on login


