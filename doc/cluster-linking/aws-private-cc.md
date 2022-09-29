
# Hybrid Cloud - AWS CP to CC via VPC peering

## 1. Environment variables
```
export CLUSTER_LINK_NAME=aws-to-private-cc

export CC_ENV_ID=env-q2n78p
export CC_CLUSTER_ID=lkc-j51p5w
export CP_CLUSTER_ID=A1sCSQ5oSA-lxzRkqQZ_7g
export SOURCE_BOOTSTRAP=ip-10-0-1-23.ap-southeast-2.compute.internal
```

## 2. Setup cluster link on Confluent Cloud
```
confluent login
confluent environment use $CC_ENV_ID
confluent kafka cluster use $CC_CLUSTER_ID

confluent kafka link create $CLUSTER_LINK_NAME \
  --cluster $CC_CLUSTER_ID \
  --source-cluster-id $CP_CLUSTER_ID \
  --config-file dst.conf
```

## 3. Setup cluster link on Confluent Platform
```
kafka-cluster-links --link $CLUSTER_LINK_NAME \
  --config-file src.conf \
  --cluster-id $CC_CLUSTER_ID \
  --bootstrap-server $SOURCE_BOOTSTRAP:9092 \
  --command-config cp-command.conf \
  --create
```

## 4. Configuration files

```
tee dst.conf << END
link.mode=DESTINATION
connection.mode=INBOUND

auto.create.mirror.topics.enable=true
auto.create.mirror.topics.filters={"topicFilters": [{"name": "web", "patternType": "PREFIXED", "filterType": "INCLUDE"}]}
END
```
```
tee src.conf << END
link.mode=SOURCE
connection.mode=OUTBOUND

bootstrap.servers=pkc-vy33z.ap-southeast-2.aws.confluent.cloud:9092
ssl.endpoint.identification.algorithm=https
security.protocol=SASL_SSL
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username='{{ api-key }}' password='{{ api-key-secret }}';

local.listener.name=INTERNAL
local.security.protocol=SASL_PLAINTEXT
local.sasl.mechanism=SCRAM-SHA-512
local.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="cpuser" password="password";

END
```

```
tee cp-command.conf << END
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="cpuser" password="password";
END