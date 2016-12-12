#!/bin/bash

#build
work=$(dirname $(pwd))
build/allimages.sh $work/mysql-sample $work/springbatch-sample $work/spring-boot-sample

#pre e2e : deploy
export ANSIBLE_HOSTS=/etc/ansible/hosts
ansible-playbook deploy/deploy.yml --extra-vars "log=$(pwd)/log configurations_dest=$(pwd)/configurations"

#pre e2e : prepare
docker run --rm  -v $(pwd)/configurations:/properties -v $(pwd)/pre-e2e/input:/input springbatch-sample > log/batch.log

#e2e : test postman
docker run --name newman-sample -v $(pwd):/etc/newman -t postman/newman_ubuntu1404 run test/restapp.postman_collection.json --environment configurations/restapp.postman_environment.json --reporters html,cli --reporter-html-export log/newman-results.html

#post e2e : clean
post-e2e/docker-stop.sh