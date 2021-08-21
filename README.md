# Getting Started

## Create Network

```bash
docker network create -d bridge kafka-cluster
```

## Launch ZooKeeper

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster --name zk \
    -p 2181:2181 \
    johnsonlee/kafka:2.8.0 \
    bin/zookeeper-server-start.sh config/zookeeper.properties
```

## Launch Kafka

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster --name kafka \
    -p 9092:9092 \
    -v "$(pwd)"/config:/opt/kafka-2.8.0/config \
    johnsonlee/kafka:2.8.0 \
    bin/kafka-server-start.sh config/server.properties
```

## Create Topic

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster \
    johnsonlee/kafka:2.8.0 \
    bin/kafka-topics.sh \
    --create \
    --topic quickstart-events \
    --bootstrap-server kafka:9092
```

## Write Events

Launching an interactive console producer by executing the following command:

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster \
    johnsonlee/kafka:2.8.0 \
    bin/kafka-console-producer.sh \
    --topic quickstart-events \
    --bootstrap-server kafka:9092
```

After the command promote `>` show in the console, then you can write events (one message per line)

## Read Events

Launching a console consumer by executing the following command:

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster \
    johnsonlee/kafka:2.8.0 \
    bin/kafka-console-consumer.sh \
    --topic quickstart-events \
    --from-beginning \
    --bootstrap-server kafka:9092
```

After you write event through the interactive console producer, the event can be received by the console consumer immediately.

## Using K6

### Create Topic for K6

```bash
docker run -it -w=/opt/kafka-2.8.0 --network=kafka-cluster \
    johnsonlee/kafka:2.8.0 \
    bin/kafka-topics.sh \
    --create \
    --topic k6 \
    --bootstrap-server kafka:9092
```

### Run K6

```bash
docker run -i --network=kafka-cluster loadimpact/k6 run \
    --logformat=raw \
    --out kafka=brokers=kafka:9092,topic=k6,format=json \
    - <scenario.js
```
