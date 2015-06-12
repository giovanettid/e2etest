host=$(docker-machine ip)
curl http://$host:8080/personnes/search?nom=nom1
echo "\n" should found 1 personne
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom3"}' http://$host:8080/personnes
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom4"}' http://$host:8080/personnes
curl http://$host:8080/personnes/search?nom=nom3
echo "\n" should found 2 personnes