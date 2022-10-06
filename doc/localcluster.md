
server.properties
```
inter.broker.listener.name=SASL_PLAINTEXT
sasl.enabled.mechanisms=SCRAM-SHA-512
sasl.mechanism.inter.broker.protocol=SCRAM-SHA-512
listener.name.sasl_plaintext.scram-sha-512.sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="kafka" password="kafka-secret";
confluent.reporters.telemetry.auto.enable=false
confluent.cluster.link.enable=true
password.encoder.secret=encoder-secret
```


```
zookeeper-server-start $CONFLUENT_CONFIG/zookeeper.properties

kafka-configs --zookeeper localhost:2181 --alter --add-config \
  'SCRAM-SHA-512=[iterations=8192,password=kafka-secret]' \
  --entity-type users --entity-name kafka

kafka-configs --zookeeper localhost:2181 --alter --add-config \
  'SCRAM-SHA-512=[iterations=8192,password=admin-secret]' \
  --entity-type users --entity-name admin

kafka-server-start $CONFLUENT_CONFIG/server.properties
```