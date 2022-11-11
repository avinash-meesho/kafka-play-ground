1. install confluent-hub
```
wget http://client.hub.confluent.io/confluent-hub-client-latest.tar.gz
tar -zxvf confluent-hub-client-latest.tar.gz
export PATH=$PATH:~/bin

sudo confluent-hub install confluentinc/kafka-connect-http:1.6.1
sudo confluent-hub install confluentinc/kafka-connect-datagen:0.6.0
sudo confluent-hub install confluentinc/kafka-connect-oracle-cdc:2.2.2
```

2. restart service
```
sudo systemctl restart confluent-kafka-connect
```

3. Data gen connector
```
topic=test2
quickstart=RATINGS
```

```
{
  "rating_id": 570,
  "user_id": 18,
  "stars": 4,
  "route_id": 4208,
  "rating_time": 6829,
  "channel": "android",
  "message": "thank you for the most friendly, helpful experience today at your new lounge"
}
```