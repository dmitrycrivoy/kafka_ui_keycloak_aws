# Kafka with UI and Keycloak on AWS


## Description

Interbroker communication: PLAINTEXT, PLAIN.

Client with broker communication: SASL_PLAINTEXT, OAUTHBEARER.


## Keycloak configuration

### Realm and clients 

1. Create your own realm in Keycloak if it doesn't exist. 

2. Create `kafka` and `kafka-ui` clients in your realm.

For both clients activate `Client authentication` option in Keycloak.

For `kafka` client activate options `Authorization`, `OAuth 2.0 Device Authorization Grant` and `OIDC CIBA Grant`.

3. In the `Credentians` tab of the client copy `Client secret` of `kafka-ui` and `kafka` clients.


## Environment configuration

We need to replace some variables with correct values in the `.env` file.

1. Write Keycloak address with port instead of `<oauth_server_address_with_port>`.

2. Write the name of the new or existed realm instead of `<realm>`.

3. Replace copied client secrets instead of `<kafka_ui_secret>` and `<kafka_secret>` respectively.

Generate basic token:

```
echo -n kafka:<kafka_secret> | base64
```

4. Replace the result of the command instead of `<token>`.


## Run Kafka

Running of Kafka with docker-compose, but we need to export `INSTANCE_PUBLIC_IP` variable first, 
because the broker will return related to port `KAFKA_ADVERTISED_LISTENERS` to the client and the client will try to connect to this address.

For all these actions you can just run the following commands:

```
chmod +x run_kafka.sh
./run_kafka.sh
```


## AWS

In `Security groups` of the instance add rule with opened port `9093` client IPs.

Also add **Kafka to Kafka** rule with the Kafka instance IP and opened port `9093`.