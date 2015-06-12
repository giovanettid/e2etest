######## chmod +x
chmod +x scripts/build/build_alljars.sh
chmod +x scripts/docker/docker_preintegration_test.sh
chmod +x scripts/check/check_restapp.sh
chmod +x scripts/docker/docker_postintegration_test.sh

######## build
#scripts/build/build_alljars.sh

######## pre integration-test
scripts/docker/docker_preintegration_test.sh

######## integration-test 
scripts/check/check_restapp.sh

######## post integration-test
scripts/docker/docker_postintegration_test.sh