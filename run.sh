#!/bin/bash

#build
work=$(dirname $(pwd))
build/allimages.sh $work/mysql-sample $work/springbatch-sample $work/spring-boot-sample

#pre e2e : deploy
export ANSIBLE_HOSTS=/etc/ansible/hosts
ansible-playbook deploy/deploy.yml --extra-vars "log=$(pwd)/log properties_dest=$(pwd)/properties"

#pre e2e : prepare
docker run --rm  -v $(pwd)/properties:/properties -v $(pwd)/pre-e2e/input:/input springbatch-sample > log/batch.log

#e2e : test
test/restapp.sh

#post e2e : clean
post-e2e/docker-stop.sh