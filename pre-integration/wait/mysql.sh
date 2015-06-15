echo -n "Waiting for mysqld alive..."
while [ $(mysqladmin -u root -pdba ping | grep 'mysqld is alive' | wc -l) -ne 1 ] 
do
    sleep 1
    echo -n "."
done