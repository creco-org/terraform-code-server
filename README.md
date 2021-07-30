# terraform-code-server

You can create code-server with aws instance by terraform!

# Requirements (mac)

- STEP1 Install terraform, direnv

```
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew install direnv
```

- Make pem file for aws instance key pair

```
ssh-keygen -b 4096 -f [my-key].pem
```

- Make .envrc for aws account and

```
export AWS_ACCESS_KEY_ID=[AWS_ACCESS_KEY_ID]
export AWS_SECRET_ACCESS_KEY=[AWS_SECRET_ACCESS_KEY]
export TF_VAR_password=[Your Code Server Password]
export TF_VAR_region=[Your AWS Region]
export TF_VAR_key_pair_name=[my-key]
export TF_VAR_key_pair_filename=[my-key.pem]
export TF_VAR_key_pair_public_key=[my-key.pub contents]
```

ex)

```envrc
export AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA
export AWS_SECRET_ACCESS_KEY=asdfghjklASDFGHJKLasdfghjklASDFGHJKLqwer
export TF_VAR_password=1234
export TF_VAR_region=ap-northeast-2
export TF_VAR_key_pair_name=my-key
export TF_VAR_key_pair_filename=my-key.pem
export TF_VAR_key_pair_public_key="ssh-rsa SOMETHING ELSE ..."
```

# License

- docker-code-server
  - https://github.com/linuxserver/docker-code-server
  - GPL-3.0 License
