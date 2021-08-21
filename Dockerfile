FROM johnsonlee/java15:latest

WORKDIR /opt/kafka-2.8.0

RUN curl -svL --verbose https://dlcdn.apache.org/kafka/2.8.0/kafka_2.13-2.8.0.tgz | tar --strip-components 1 -xvz

