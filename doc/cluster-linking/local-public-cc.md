# Local CP to CC

## 1. Environment variables
```
export CLUSTER_LINK_NAME=from-on-prem-link 

export CC_ENV_ID=env-q2n78p
export CC_CLUSTER_ID=lkc-7yxqpj
export CP_CLUSTER_ID=PYWRtcB1Qxu1V6WyUk5rNw

export SOURCE_BOOTSTRAP=localhost
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
- dst.conf
    ```
    link.mode=DESTINATION
    connection.mode=INBOUND
    ```
- src.conf
    ```
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
    local.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="{{ scram-user }}" password="{{ scram-password }}";
    ```

- cp-command.conf
    ```
    sasl.mechanism=SCRAM-SHA-512
    security.protocol=SASL_PLAINTEXT
    sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required \
    username="admin" \
    password="admin-secret";
    ```

## Reference

[https://docs.confluent.io/cloud/current/multi-cloud/cluster-linking/hybrid-cc.html](https://docs.confluent.io/cloud/current/multi-cloud/cluster-linking/hybrid-cc.html)