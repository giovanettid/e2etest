#!/bin/bash

export e2e=$(pwd) && export work=$e2e/.. && export host=$(docker-machine ip)
find . -name "*.sh" | xargs chmod +x