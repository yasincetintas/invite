#!/usr/bin/env bash
docker-compose stop
docker-compose rm -f
rm -fr ./vendor
rm -fr ./var/cache
docker-compose up -d --force-recreate
docker exec -it invite_app bash -c "cd /var/vhosts/invite && chown -R www-data:www-data /var/vhosts && sudo -u www-data /usr/local/bin/composer update"
sleep 15
docker exec -it invite_app bash -c "cd /var/vhosts/invite  && sudo -u www-data bin/console c:c"
docker cp invite_app:/var/vhosts/invite/vendor ./
docker cp invite_app:/var/vhosts/var/cache ./var/cache
#sleep 15
#docker exec -it invite_db /home/initdb.sh