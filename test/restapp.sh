
echo BEGIN TEST...
curl -s http://$host:8080/personnes/search?nom=nom1 2>&1 | tee $work/log/test.log
echo "\n" SHOULD FOUND 1 personne
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom3"}' http://$host:8080/personnes
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom4"}' http://$host:8080/personnes
curl -s http://$host:8080/personnes/search?nom=nom3 2>&1 | tee -a $work/log/test.log
echo "\n" SHOULD FOUND 2 personnes
echo END TEST