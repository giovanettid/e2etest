#!/bin/bash
input=$1
log=$2
properties=$3

docker run --name mysqldb -d -e MYSQL_ROOT_PASSWORD=dba -p 3306:3306 mysql-sample

pre-integration/wait/wait.sh mysqldb

docker run --rm  -v $properties:/properties -v $input:/input springbatch-sample > log/batch.log

docker run --name webapp -d -v $log/:/var/log -v $properties:/properties -p 8080:8080 spring-boot-sample

pre-integration/wait/wait.sh webapp
