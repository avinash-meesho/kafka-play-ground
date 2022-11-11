create stream

```
CREATE STREAM Ratings (rating_id bigint, message VARCHAR) 
        WITH (KAFKA_TOPIC='ratings.topic', VALUE_FORMAT='AVRO');
```

```
SELECT * FROM Ratings LIMIT 3;
```

sudo systemctl status confluent-ksqldb

sudo journalctl -u confluent-ksqldb

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

curl --insecure -X "POST" "https://ksql-0.shin.ps.confluent.io:8088/query" \
     -d $'{
  "ksql": "SELECT * FROM RATINGS LIMIT 3;",
  "streamsProperties": {
    "ksql.streams.auto.offset.reset": "earliest"
  }
}'