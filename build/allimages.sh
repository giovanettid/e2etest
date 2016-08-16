#!/bin/bash
work=$1

cd $work/mysql-sample && docker build -t mysql-sample:latest .
cd $work/springbatch-sample && mvn clean package && docker build -t springbatch-sample:latest .
cd $work/spring-boot-sample && mvn clean package && docker build -t spring-boot-sample:latest .

