#!/bin/bash
mysql=$1
batch=$2
restapp=$3

cd $mysql && docker build -t mysql-sample:latest .
cd $batch && mvn clean package
cd $restapp && mvn clean package
