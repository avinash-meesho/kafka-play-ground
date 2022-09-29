## Console Producer

### Configuration
```shell
export BROKER=ip-10-0-1-210.ap-southeast-2.compute.internal
export TOPIC=web.seq

tee conn.conf << END
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="{{ scram-user }}" password="{{ scram-password }}";
END
```

### Produce
```
kafka-topics --create --topic $TOPIC \
  --partitions 3 \
  --replication-factor 3 \
  --bootstrap-server $BROKER:9092 \
  --command-config conn.conf

seq 1 100 | kafka-console-producer --topic $TOPIC \
  --bootstrap-server $BROKER:9092 \
  --producer.config conn.conf

kafka-console-consumer --topic $TOPIC \
  --from-beginning \
  --bootstrap-server $BROKER:9092 \
  --consumer.config conn.conf
```

## Arvo Console Producer
## Configuration
```shell
export BROKER=ip-10-0-1-210.ap-southeast-2.compute.internal
export SCHEMA_REGISTRY=ip-10-0-1-75.ap-southeast-2.compute.internal
export TOPIC=web.schema-link

tee conn.conf << END
security.protocol=SASL_PLAINTEXT
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="cpuser" password="password";
END
```

## Produce
```shell
kafka-avro-console-producer \
  --topic $TOPIC \
  --bootstrap-server $BROKER:9091 \
  --property parse.key=true \
  --property key.separator="|" \
  --property schema.registry.url=$SCHEMA_REGISTRY \
  --property key.schema='{"type":"string"}' \
  --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"gcp","type":"int"}]}' \
  --producer.config conn.conf 

"k1"|{"gcp": 1}
"k2"|{"gcp": 2}
"k3"|{"gcp": 3}
"k4"|{"gcp": 4}

kafka-avro-console-consumer \
  --topic $TOPIC \
  --from-beginning \
  --bootstrap-server $BROKER:9092 \
  --property parse.key=true \
  --property key.separator="|" \
  --property schema.registry.url=$SCHEMA_REGISTRY \
  --consumer.config conn.conf
```

```shell
kafka-avro-console-producer \
  --topic $TOPIC \
  --bootstrap-server $BROKER:9091 \
  --property parse.key=true \
  --property key.separator="|" \
  --property schema.registry.url=http://$SCHEMA_REGISTRY:8081 \
  --property key.schema.id=1 \
  --property value.schema.id=3 \
  --producer.config conn.conf 
```

```
export SCHEMA_REGISTRY_CREDS={API-KEY}:{API-SECRET}

kafka-avro-console-consumer \
  --topic web.server \
  --from-beginning \
  --bootstrap-server pkc-vy33z.ap-southeast-2.aws.confluent.cloud:9092 \
  --property parse.key=true \
  --property key.separator="|" \
  --property schema.registry.url=https://psrc-7q7vj.ap-southeast-2.aws.confluent.cloud \
  --property schema.registry.basic.auth.credentials.source=USER_INFO \
  --property schema.registry.basic.auth.user.info=$SCHEMA_REGISTRY_CREDS \
  --consumer.config cc-conn.conf
```