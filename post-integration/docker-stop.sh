######## post integration-test
# remove containers
docker stop webapp && docker rm webapp && docker stop mysqldb && docker rm mysqldb