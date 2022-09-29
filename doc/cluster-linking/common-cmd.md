
## Create cluster
```shell
export CLUSTER_NAME=local-linking
confluent kafka cluster create $CLUSTER_NAME \
  --type dedicated \
  --cloud aws \
  --region ap-southeast-2 \
  --cku 1 \
  --availability single-zone
```

## Cluster link
```shell
confluent kafka link list
confluent kafka link describe $CLUSTER_LINK_NAME

tee dst-mirror.conf << END
link.mode=DESTINATION
auto.create.mirror.topics.enable=false
END
confluent kafka link update $CLUSTER_LINK_NAME --config-file dst-mirror.conf

confluent kafka link delete $CLUSTER_LINK_NAME
```

## Cluster mirror topic
```
confluent kafka mirror list
confluent kafka mirror create $TOPIC --link $CLUSTER_LINK_NAME
```

