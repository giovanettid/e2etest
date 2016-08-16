#!/bin/bash
work=$(dirname $(pwd))

build/allimages.sh $work

pre-integration/docker-run.sh $work $(pwd)

test/restapp.sh $work

post-integration/docker-stop.sh
