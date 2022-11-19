
Create Certificate Authority

```
export VALIDITY=365
export KEY_PASS=passwd
export STORE_PASS=passwd
export DOMAIN=shin.ps.confluent.io
```
VALIDITY=90
KEY_PASS=password
openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY -subj "/C=CN/O=BBA/OU=IT/L=Shengyang/ST=Liaoning/CN=testuser" -passout pass:$KEY_PASS

1. Create CA

```
openssl req -new -x509 -keyout ca-key -out ca-cert -days $VALIDITY -subj "/C=AU/O=Confluent/OU=PS/CN=*.$DOMAIN" -passout pass:$KEY_PASS
```

2. Add generated CA to all client
```
keytool -keystore kafka.client.truststore.jks -alias CARoot -importcert -file ca-cert -storepass $STORE_PASS -noprompt

```

3. Create server keystore and truststore
```
export HOSTNAME=c3-0
export KEY_STORE_NAME=$HOSTNAME.keystore.jks
export TRUST_STORE_NAME=$HOSTNAME.truststore.jks

# create keystore with key and cert
keytool -keystore $KEY_STORE_NAME -alias $HOSTNAME -keyalg RSA -validity $VALIDITY -genkey -storepass $STORE_PASS -keypass $KEY_PASS -dname "CN=$HOSTNAME.$DOMAIN"

# export host cert
keytool -keystore $KEY_STORE_NAME -alias $HOSTNAME -certreq -file $HOSTNAME-cert -storepass $STORE_PASS

# sign host cert
openssl x509 -req -CA ca-cert -CAkey ca-key -in $HOSTNAME-cert -out $HOSTNAME-cert-signed -days $VALIDITY -CAcreateserial -passin pass:$KEY_PASS

keytool -keystore $KEY_STORE_NAME -alias CARoot -importcert -file ca-cert -storepass $STORE_PASS -noprompt
keytool -keystore $KEY_STORE_NAME -alias $HOSTNAME -importcert -file $HOSTNAME-cert-signed -storepass $STORE_PASS -noprompt
keytool -keystore $TRUST_STORE_NAME -alias CARoot -importcert -file ca-cert -storepass $STORE_PASS -noprompt
```


```
keytool -list -v -keystore $KEY_STORE_NAME.jks
```

3. mTLS client login
```
security.protocol=SSL
ssl.keystore.type=PEM
ssl.keystore.certificate.chain=-----BEGIN CERTIFICATE-----\nMIIDZjC...\n-----END CERTIFICATE-----
ssl.keystore.key=-----BEGIN ENCRYPTED PRIVATE KEY-----\n...\n-----END ENCRYPTED PRIVATE KEY-----
ssl.key.password=<private_key_password>
ssl.truststore.type=PEM
ssl.truststore.certificates=-----BEGIN CERTIFICATE-----\nMICC...\n-----END CERTIFICATE-----
```