# Requirements
Terraform version v1.3.6\
provider - v2.22.0



# Install pip for non-sudo user
Reference: https://gist.github.com/saurabhshri/46e4069164b87a708b39d947e4527298
```bash
#Download .py install file and run as user
wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py --user
#set python PATH
ENV PYTHONPATH /opt/.local/bin
```

# Call Lambda function using AWS CLI

1. Save following JSON to input.txt

```json
{
    "operation": "echo",
    "payload": {
        "somekey1": "somevalue1",
        "somekey2": "somevalue2"
    }
}
```

2. Run command

aws lambda invoke --function-name LambdaFunctionOverHttps \
--payload file://input.txt outputfile.txt 

## Note

Edit webpage.py to make changes to the flask website / API



