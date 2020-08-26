#!/bin/bash

until (apt update); do
  echo "Sleeping 10s"
  sleep 10
done

apt upgrade -y
apt install -y redis

sed -i.bkp -e 's/^bind 127.0.0.1 ::1/#bind 127.0.0.1 ::1/g' /etc/redis/redis.conf

systemctl restart redis
