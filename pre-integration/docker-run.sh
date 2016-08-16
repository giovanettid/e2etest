#!/bin/bash
work=$1
e2e=$2

cd $work && rm -rf log && mkdir log

docker run --name mysqldb -d -e MYSQL_ROOT_PASSWORD=dba -p 3306:3306 mysql-sample

$e2e/pre-integration/wait/wait.sh mysqldb

docker run --rm  -v $work/configuration/properties:/properties -v $e2e/pre-integration/input:/input springbatch-sample > $work/log/batch.log	

docker run --name webapp -d -v $work/log/:/var/log -v $work/configuration/properties:/properties -p 8080:8080 spring-boot-sample

$e2e/pre-integration/wait/wait.sh webapp




