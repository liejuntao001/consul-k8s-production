# create acls

## Run below command with export CONSUL_HTTP_TOKEN=<root_token>

## for agent

```
consul acl policy create -name "agent" \
                         -description "This is an policy for agent to access consul" \
                         -rules @agent.hcl

consul acl policy update -name "agent" \
                         -description "This is an policy for agent to access consul" \
                         -rules @agent.hcl

consul acl role create -name "agent" -policy-name="agent"

consul acl token create -description "agent token" \
                         -policy-name "agent" \
                         -role-name "agent"
```

## for anonymous

```
consul acl policy create -name "anonymous" \
                         -description "This is an policy for anonymous" \
                         -rules @anonymous.hcl

consul acl policy update -name "anonymous" \
                         -description "This is an policy for anonymous" \
                         -rules @anonymous.hcl

consul acl token update -id "00000000-0000-0000-0000-000000000002" -policy-name "anonymous"

```

## for traefik

```
consul acl policy create -name "traefik" \
                         -description "This is an policy for traefik to access consul" \
                         -rules @traefik.hcl

consul acl policy update -name "traefik" \
                         -description "This is an policy for traefik to access consul" \
                         -rules @traefik.hcl

consul acl role create -name "traefik" -policy-name="traefik"

consul acl token create -description "traefik token" \
                        -policy-name "traefik" \
                        -role-name "traefik"
```

## for vault

```
consul acl policy create -name "vault" \
                         -description "This is an policy for vault to access consul" \
                         -rules @vault.hcl

consul acl role create -name "vault" -policy-name="vault"

consul acl token create -description "vault token" \
                        -policy-name "vault" \
                        -role-name "vault"
```

# for vault-unlock

```
consul acl policy create -name "vault-unlock" \
                         -description "This is an policy for vault-unlock to access consul" \
                         -rules @vault-unlock.hcl

consul acl role create -name "vault-unlock" -policy-name="vault-unlock"

consul acl token create -description "vault-unlock token" \
                        -policy-name "vault-unlock" \
                        -role-name "vault-unlock"
```

# other commands

```
consul acl token list

consul acl token read -id xxxx
```
