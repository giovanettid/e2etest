#!/bin/bash

build/alljars.sh

pre-integration/docker-run.sh

test/restapp.sh

post-integration/docker-stop.sh
