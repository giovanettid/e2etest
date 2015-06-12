########## clone
git clone https://github.com/giovanettid/springbatch-sample.git
git clone https://github.com/giovanettid/spring-boot-sample.git
git clone https://github.com/giovanettid/configuration.git

########## build
e2e=$(pwd)
cd $e2e/springbatch-sample && mvn clean package

cd $e2e/spring-boot-sample && mvn clean package

cd $e2e && mkdir dist
cp springbatch-sample/springbatch-sample/target/*.jar dist/springbatch-sample.jar
cp spring-boot-sample/target/*.jar dist/spring-boot-sample.jar