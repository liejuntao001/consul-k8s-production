# Step 1 bootstrap Consul cluster without ACL

```
kubectl apply -f consul_namespace.yml

kubectl apply -f consul_service.yml

kubectl apply -f consul_serviceaccount.yml

kubectl -n consul create configmap consul --from-file=config.json=config/01_no_acl_config.json -o yaml --dry-run | kubectl replace -f -

kubectl apply -f 01consul_statefulset_noacl.yml
```

# Step 2 Enable ACL without enforcing it

```
# modify config
kubectl -n consul create configmap consul --from-file=config.json=config/02_acl_allow_config.json -o yaml --dry-run | kubectl replace -f -

# apply step 2
kubectl apply -f 02consul_statefulset_acl_allow.yml

# create master token
consul acl bootstrap

```

## Create ACL rules and get the tokens

Refer to README.md in acl folder. Get all the tokens ready.

# Step 3 Enable ACL and enforce it

```
# create secret for ACL tokens
ACL_TOKENS_AGENT=<token_vaule> ; ACL_TOKENS_MANAGEMENT=<token_vaule> ; kubectl -n consul create secret generic tokens --from-literal="acl.tokens.agent=${ACL_TOKENS_AGENT}" --from-literal="acl.tokens.management=${ACL_TOKENS_MANAGEMENT}"

# modify config
kubectl -n consul create configmap consul --from-file=config.json=config/03_acl_deny_config.json -o yaml --dry-run | kubectl replace -f -

# apply step 3
kubectl apply -f 03consul_statefulset_acl_deny.yml
```

# Step 4 Producution tuning

```
# modify config
kubectl -n consul create configmap consul --from-file=config/config.json -o yaml --dry-run | kubectl replace -f -

# apply step 4
kubectl apply -f consul_statefulset.yml
```

# Setup backup cronjob
```
# create the secret
AWS_ACCESS_KEY_ID=<aws_access_key> ;AWS_SECRET_ACCESS_KEY=<aws_secret_key>; RESTIC_REPOSITORY=<restic_repository>; RESTIC_PASSWORD=<restic_password>; kubectl -n consul create secret generic restic-secrets --from-literal="AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID=}" --from-literal="AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY=}" --from-literal="RESTIC_REPOSITORY=${RESTIC_REPOSITORY}" --from-literal="RESTIC_PASSWORD=${RESTIC_PASSWORD}"

# create pvc
kubectl apply -f consul_backup_pvc.yml

# do a test to run the job once
kubectl apply -f consul_backup_job.yml

# install cronjob
kubectl apply -f consul_backup_cronjob.yml
```