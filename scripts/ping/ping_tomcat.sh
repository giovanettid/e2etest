echo -n "Waiting for tomcat listen..."
while [ $(cat /var/log/stdout.log | grep 'Tomcat started on port' | wc -l) -ne 1 ] 
do
    sleep 1
    echo -n "."
done