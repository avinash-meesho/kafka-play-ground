
# Login to confluent cloud

```
confluent environment list
confluent kafka cluster list --environment {env_id}

export CC_ENV_ID=env-12ooq3


# cluster_sgp as Primary
export PR_CLUSTER_ID=lkc-j5pg9p

# cluster_syd as Disaster Recovery
export DR_CLUSTER_ID=lkc-pg23jm

confluent environment use $CC_ENV_ID
confluent kafka cluster use $PR_CLUSTER_ID
```

# Setup cluster link via Confluent console

- environment
- cluster
- sync consumer group offset
- mirror topic

# Fail over
```
confluent kafka cluster use $DR_CLUSTER_ID
confluent kafka mirror list
confluent kafka mirror failover sgp.web.test.topic --link cluster_link_sgp_syd
```

# Setup fallback cluster link

```
confluent kafka cluster use $DR_CLUSTER_ID

tee syd.conf << END

consumer.offset.sync.enable=true
topic.config.sync.ms=1000

security.protocol=SASL_SSL
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="44ZZLTE4KHX4K5BC" password="9MHgmezPHIJd95LmiITfbKjfPI8Nh8RAelVZI1L4fW+PxcKygvpFryvOQXLL3RKP";

END


```
