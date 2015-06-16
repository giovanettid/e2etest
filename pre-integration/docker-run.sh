#!/bin/bash

cd $work && rm -rf log && mkdir log

# docker run mysql container & wait
echo RUN MYSQL 
docker run --name mysqldb -d -v $work/configuration/:/configuration -v $e2e/pre-integration/:/pre-integration \
		   -e MYSQL_USER=mysql -e MYSQL_PASSWORD=mysql -e MYSQL_ROOT_PASSWORD=dba -p 3306:3306 mysql:5.7.7
echo WAIT MYSQL
docker exec mysqldb bash /pre-integration/wait/mysql.sh

# docker exec ddl sql scripts
echo EXECUTE functional schema
docker exec mysqldb bash -c "mysql -u root -pdba < configuration/sql/functional-schema.sql"
echo EXECUTE technical schema
docker exec mysqldb bash -c "mysql -u root -pdba < configuration/sql/technical-schema.sql"

# docker run batch
echo RUN JAVA BATCH
batch_name=springbatch-sample
job_name=alimentationJob
job_param=input.file.path=/pre-integration/input/alimentation.csv

docker run --rm -v $work/configuration/:/configuration -v $work/dist/:/dist -v $e2e/pre-integration/:/pre-integration \
		   java:8 java -Dbatch.properties.path=file:/configuration/properties/batch.properties -Djob.name=$job_name \
		   		       -jar /dist/$batch_name.jar $job_param \
	> $work/log/batch.log

# docker run rest webapp & wait
echo RUN JAVA WEBAPP
restapp_name=spring-boot-sample
redirect_log="2>&1 | tee /var/log/restapp.log"
run_restapp="java -jar /dist/$restapp_name.jar --spring.config.location=file:/configuration/properties/application.properties $redirect_log"

docker run --name webapp -d -v $work/configuration/:/configuration -v $work/dist/:/dist -v $work/log/:/var/log \
							-v $e2e/pre-integration/:/pre-integration --expose 8080 -p 8080:8080 \
			java:8 bash -c "$run_restapp"
echo WAIT JAVA WEBAPP
docker exec webapp bash /pre-integration/wait/tomcat.sh
