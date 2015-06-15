
######### start machine
docker-machine start

######### set env
source ~/.docker/machine/machines/dev2/dev2.sh

######### clone 
git clone https://github.com/giovanettid/e2etest.git

git clone https://github.com/giovanettid/springbatch-sample.git

git clone https://github.com/giovanettid/spring-boot-sample.git

git clone https://github.com/giovanettid/configuration.git

######## e2e test
export work=$(pwd) && export e2e=$work/e2etest && export host=$(docker-machine ip)

find . -name "*.sh" | xargs chmod +x && cd e2etest && ./run.sh && cd $work

######## stop machine
docker-machine stop

######### todo 
multi line commands

add variables