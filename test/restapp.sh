#!/bin/bash

echo BEGIN TEST...
curl -s http://localhost:8080/personnes/search?nom=nom1 2>&1 | tee log/test.log
echo -e "\nSHOULD FOUND 1 personne"
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom3"}' http://localhost:8080/personnes
curl -H "Content-Type: application/json" -X POST -d '{"nom":"nom3","prenom":"prenom4"}' http://localhost:8080/personnes
curl -s http://localhost:8080/personnes/search?nom=nom3 2>&1 | tee -a log/test.log
echo -e "\nSHOULD FOUND 2 personnes"
echo END TEST