if [ "$#" -ne 1 ]; then
    echo "Invalid number of parameters. Example execution command: bash deploy.sh <uat/prod/dev>"
    exit 1
else
    if [[ "$1" != "uat" && "$1" != "prod" && "$1" != "dev" ]]; then
        echo "Input should either be 'uat' or 'prod'. Given input: $1"
        exit 1
    fi
fi

terraform init -reconfigure -var-file=$1/$1.tfvars
terraform fmt -recursive
terraform apply -var-file=$1/$1.tfvars 

echo "Terraform Completed"