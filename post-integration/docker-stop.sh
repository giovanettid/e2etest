#!/bin/bash

docker rmi springbatch-sample
docker stop webapp && docker rm webapp && docker rmi spring-boot-sample
docker stop mysqldb && docker rm mysqldb && docker rmi mysql-sample 
