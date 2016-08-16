#!/bin/bash
work=$(dirname $(pwd))

build/alljars.sh $work

pre-integration/docker-run.sh $work $(pwd)

test/restapp.sh $work

post-integration/docker-stop.sh
