
cd $work/springbatch-sample && mvn clean package

cd $work/spring-boot-sample && mvn clean package

cd $work && rm -rf dist && mkdir dist
cp springbatch-sample/springbatch-sample/target/*.jar dist/springbatch-sample.jar
cp spring-boot-sample/target/*.jar dist/spring-boot-sample.jar