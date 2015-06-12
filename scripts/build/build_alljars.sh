########## clone
git clone https://github.com/giovanettid/springbatch-sample.git
git clone https://github.com/giovanettid/spring-boot-sample.git
git clone https://github.com/giovanettid/configuration.git

######### e2e path
e2e=$(pwd)

########## build
cd $e2e/springbatch-sample && mvn clean package

cd $e2e/spring-boot-sample && mvn clean package

cd $e2e && mkdir dist
cp springbatch-sample/springbatch-sample/target/*.jar dist/springbatch-sample.jar
cp spring-boot-sample/target/*.jar dist/spring-boot-sample.jar