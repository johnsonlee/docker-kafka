FROM johnsonlee/java:15.0.2

WORKDIR /opt/kafka-2.8.0

RUN curl -sL https://downloads.apache.org/kafka/2.8.0/kafka_2.13-2.8.0.tgz | tar --strip-components 1 -xvz

