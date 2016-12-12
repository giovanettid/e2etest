
####### configure ansible 
editer /etc/ansible/hosts

[local]

127.0.0.1 configurations_url=https://raw.githubusercontent.com/giovanettid/configuration/master

####### clone 
git clone https://github.com/giovanettid/springbatch-sample.git

git clone https://github.com/giovanettid/spring-boot-sample.git

git clone https://github.com/giovanettid/mysql-sample.git

git clone https://github.com/giovanettid/e2etest.git && cd e2etest && git checkout e2e-docker-ansible

####### run e2e test
./run.sh
