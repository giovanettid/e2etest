#!/bin/bash
work=$(dirname $(pwd))
e2e=$(pwd)

#build
build/allimages.sh $work/mysql-sample $work/springbatch-sample $work/spring-boot-sample

#pre e2e
cd $e2e && rm -rf log && mkdir log
pre-integration/docker-run.sh $e2e/pre-integration/input $e2e/log $work/configuration/properties

#e2e
test/restapp.sh

#post e2e
post-integration/docker-stop.sh
