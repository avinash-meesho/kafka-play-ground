# Schema linking - CP to CC

## Create API key and secret in CC

Schema registry is an environment resource. You should be able to create it in the CC environment page.

## Create destination configuration

```
tee dst-schema-registry.conf << END
schema.registry.url=https://psrc-7q7vj.ap-southeast-2.aws.confluent.cloud
basic.auth.credentials.source=USER_INFO
basic.auth.user.info={{ api-key }}:{{ api-secret }}
END
```

## Create exporter in CP

```
export SCHEMA_REGISTRY=http://ip-10-0-1-75.ap-southeast-2.compute.internal:8081/
export EXPORTER_NAME=exporter-from-cp

schema-exporter \
  --schema.registry.url $SCHEMA_REGISTRY \
  --create --name $EXPORTER_NAME \
  --subjects ":*:" \
  --config-file dst-schema-registry.conf
```

## Other commands

check status
```
schema-exporter --get-status --name $EXPORTER_NAME --schema.registry.url $SCHEMA_REGISTRY
```
delete
```
schema-exporter --list --schema.registry.url $SCHEMA_REGISTRY
schema-exporter --pause --name $EXPORTER_NAME --schema.registry.url $SCHEMA_REGISTRY
schema-exporter --delete --name $EXPORTER_NAME --schema.registry.url $SCHEMA_REGISTRY
```
check schema
```
curl $SCHEMA_REGISTRY/subjects
curl $SCHEMA_REGISTRY/schemas/ids/1
```

create exporter in CC
```
confluent login
confluent environment set $CC_ENV_ID

confluent schema-registry exporter create $EXPORTER_NAME --subjects ":*:" --config-file dst-schema-registry.conf

confluent schema-registry exporter get-status $EXPORTER_NAME
```

## Reference

[https://docs.confluent.io/cloud/current/sr/schema-linking.html](https://docs.confluent.io/cloud/current/sr/schema-linking.html)