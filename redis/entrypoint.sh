#!/bin/bash

#change permissions
chmod -R 0777 /opt/bitnami
chmod -R 0777 /bitnami/redis

cp ./redis/redis.conf /opt/bitnami/redis/etc/redis.conf
