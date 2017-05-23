#!/bin/bash

while [ `curl -s -o /dev/null -w "%{http_code}" ${manager}/swarm_token.html` = "404" ]
do
  echo 'waiting for master to setup'
  sleep 5
done

docker swarm join --token `curl -s ${manager}/swarm_token.html` ${manager}:2377
