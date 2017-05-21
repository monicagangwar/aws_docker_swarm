#!/bin/bash

profile="mon"
bucket="mon_terraform_tfstate_bucket"
cur_dir=$PWD
light_red="\033[1;31m"
NC="\033[0m"

#check if bucket exists already
tfstate_bucket=$(aws s3 ls --profile $profile | grep $bucket)
if [ "$tfstate_bucket" = "" ]; then
  echo "tfstate bucket does not exist. Creating the bucket ... "
  cd setup/aws
  terraform apply
  cd $cur_dir
fi

dirs=("global" "nodes" "vpc")

for dir in "${dirs[@]}"
do
  cd $cur_dir/$dir
  echo -e "${light_red}$dir${NC}"
  terraform remote config -backend=s3 -backend-config="bucket=$bucket" -backend-config="key=$dir/terraform.tfstate" -backend-config="region=us-east-1" -backend-config="encrypt=true"
  cd $cur_dir
done
