#!/usr/bin/env bash
# Install yc console
# curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
# # init yc
# yc init
# List Clouds
yc resource-manager cloud list
DEFAULT_YC_CLOUD_NAME=$(yc resource-manager cloud list --format=json | jq  --raw-output '.[0].name')
# Enter cloud name
echo "Select cloud"
read -p "Enter cloud name: (Default: $DEFAULT_YC_CLOUD_NAME) " YC_CLOUD_NAME
if [ -z "$YC_CLOUD_NAME" ]
  then
    YC_CLOUD_NAME=$DEFAULT_YC_CLOUD_NAME
fi
# get cloud id from name
export YC_CLOUD_ID=$(yc resource-manager cloud get --name $YC_CLOUD_NAME --format json | jq --raw-output .id)

# Get folder id
yc resource-manager folder list
DEFAULT_YC_FOLDER_NAME=$(yc resource-manager folder list --format=json | jq  --raw-output '.[0].name')
echo "Select folder"
read -p "Enter cloud name: (Default: $DEFAULT_YC_FOLDER_NAME) " YC_FOLDER_NAME
if [ -z "$YC_FOLDER_NAME" ]
  then
    YC_FOLDER_NAME=$DEFAULT_YC_FOLDER_NAME
fi
export YC_FOLDER_ID=$(yc resource-manager folder get --name $YC_FOLDER_NAME --format json | jq --raw-output .id )

# Get Service account
yc iam service-account list
DEFAULT_YC_SERVICE_ACCOUNT_NAME=$(yc iam service-account list --format=json | jq  --raw-output '.[0].name')
echo "Select Service account"
read -p "Enter service account name: (Default: $DEFAULT_YC_SERVICE_ACCOUNT_NAME) " YC_SERVICE_ACCOUNT_NAME
if [ -z "$YC_SERVICE_ACCOUNT_NAME" ]
  then
    YC_SERVICE_ACCOUNT_NAME=$DEFAULT_YC_SERVICE_ACCOUNT_NAME
fi
export YC_SERVICE_ACCOUNT_NAME=$YC_SERVICE_ACCOUNT_NAME
export YC_SERVICE_ACCOUNT_ID=$(yc iam service-account list --format=json | jq --raw-output '.[0].id')
export YC_TOKEN=$(yc iam create-token)
# Get compute zone
yc compute zone list
DAFAULT_YC_ZONE=$(yc compute zone list --format=json | jq  --raw-output '.[0].id')
echo "Select Zone"
read -p "Enter zone name: (Default: $DAFAULT_YC_ZONE) " YC_ZONE
if [ -z "$YC_ZONE" ]
  then
    YC_ZONE=$DAFAULT_YC_ZONE
fi

export YC_ZONE=$YC_ZONE
export TF_VAR_folder_id=$YC_FOLDER_ID
export TF_VAR_sa_name=$YC_SERVICE_ACCOUNT_NAME
export TF_VAR_sa_id=$YC_SERVICE_ACCOUNT_ID
export TF_VAR_zone_id=$YC_ZONE

read -p "Create or destroy cluster: (c/d) " YC_K8S_DESTROY
cd terraform
if [[ $YC_K8S_DESTROY = "d" ]]
  then
    echo "DESTROY CLUSTER"
    terraform destroy
elif [[ $YC_K8S_DESTROY = "c" ]]
  then
    echo "Create Cluster"
    terraform init
    terraform plan
    terraform apply
else
  echo "Nothing to do"
fi
