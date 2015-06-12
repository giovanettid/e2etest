######## pre integration-test
# docker run mysql container & ping
docker run --name mysqldb -d -v $e2e/configuration/:/configuration -v $e2e/scripts/:/scripts -e MYSQL_USER=mysql -e MYSQL_PASSWORD=mysql -e MYSQL_ROOT_PASSWORD=dba -p 3306:3306 mysql:5.7.7
docker exec mysqldb bash /scripts/ping/ping_mysql.sh

# docker exec create database schema
docker exec mysqldb bash -c 'mysql -u root -pdba < configuration/sql/functional-schema.sql'
docker exec mysqldb bash -c 'mysql -u root -pdba < configuration/sql/technical-schema.sql'

# docker run batch alimentation
docker run --rm -v $e2e/configuration/:/configuration $e2e/input/:/input -v $e2e/dist/:/dist java:8 java -Dbatch.properties.path=file:/configuration/properties/batch.properties -Djob.name=alimentationJob -jar /dist/springbatch-sample.jar input.file.path=/input/alimentation.csv > $test_path/stdout.log

# docker run rest webapp & ping
docker run --name webapp -d -v $e2e/configuration/:/configuration -v $e2e/scripts/:/scripts -v $e2e/dist/:/dist --expose 8080 -p 8080:8080 java:8 bash -c 'java -jar /dist/spring-boot-sample.jar --spring.config.location=file:/configuration/properties/application.properties 2>&1 | tee /var/log/stdout.log'
docker exec webapp bash /scripts/ping/ping_tomcat.sh