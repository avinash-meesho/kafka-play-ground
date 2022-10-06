


```
kubectl create ns dst
kubectl create ns src

kubectl create secret generic dst-cloud-plain \
  --from-file=plain.txt=dst-creds.txt \
  --namespace dst

kubectl create secret generic cloud-sr-access \
  --from-file=basic.txt=schema-creds.txt \
  --namespace dst

kubectl create secret generic src-cloud-plain \
  --from-file=plain.txt=src-creds.txt \
  --namespace src

kubectl create secret generic cloud-sr-access \
  --from-file=basic.txt=schema-creds.txt \
  --namespace src
```

replicator is consumer + producer. 

- it is not locking the destination topic
    - if there is an existing topic, the replicator will produce into it
    - topic name can be renamed with a formatter during replicating
- offset in source topic may change in destination topic, if other producer input to destination topic
- replicator will restart if the target topic is not found
- partition number will follow the source topic
- if source topic is deleted and recreated, the replication will continue from the old offset. Nothing would be replicated from SRC to DST until the new offset reached to the old one
- circular replication may happen with the default configuration, to prevent circular replication,`provenance.header.enable` needs to be true. Header will be added to message with replicator information