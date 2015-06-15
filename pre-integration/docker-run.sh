rm -rf log && mkdir log

######## pre integration-test
# docker run mysql container & ping
echo RUN MYSQL... 
docker run --name mysqldb -d -v $work/configuration/:/configuration -v $e2e/pre-integration/:/pre-integration -e MYSQL_USER=mysql -e MYSQL_PASSWORD=mysql -e MYSQL_ROOT_PASSWORD=dba -p 3306:3306 mysql:5.7.7
docker exec mysqldb bash /pre-integration/wait/mysql.sh
echo MYSQL START

# docker exec create database schema
echo EXECUTE functional schema...
docker exec mysqldb bash -c 'mysql -u root -pdba < configuration/sql/functional-schema.sql'
echo EXECUTE functional schema OK 
echo EXECUTE technical schema...
docker exec mysqldb bash -c 'mysql -u root -pdba < configuration/sql/technical-schema.sql'
echo EXECUTE technical schema OK 

# docker run batch alimentation
echo RUN JAVA BATCH...
docker run --rm -v $work/configuration/:/configuration -v $work/dist/:/dist -v $e2e/pre-integration/:/pre-integration java:8 java -Dbatch.properties.path=file:/configuration/properties/batch.properties -Djob.name=alimentationJob -jar /dist/springbatch-sample.jar input.file.path=/pre-integration/input/alimentation.csv > $work/log/batch.log
echo JAVA BATCH COMPLETED

# docker run rest webapp & ping
echo RUN JAVA WEBAPP
docker run --name webapp -d -v $work/configuration/:/configuration -v $work/dist/:/dist -v $work/log/:/var/log -v $e2e/pre-integration/:/pre-integration --expose 8080 -p 8080:8080 java:8 bash -c 'java -jar /dist/spring-boot-sample.jar --spring.config.location=file:/configuration/properties/application.properties 2>&1 | tee /var/log/restapp.log'
docker exec webapp bash /pre-integration/wait/tomcat.sh
echo JAVA WEBAPP START
