
### start docker machine
docker-machine start

### clone 
git clone https://github.com/giovanettid/e2etest.git

git clone https://github.com/giovanettid/springbatch-sample.git

git clone https://github.com/giovanettid/spring-boot-sample.git

git clone https://github.com/giovanettid/configuration.git

### run e2e test
cd e2etest && source env.sh && ./run.sh

### stop docker machine
docker-machine stop
