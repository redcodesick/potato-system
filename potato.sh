#!/bin/bash
set -e # exit when error

cat << "EOF"

 ______________
|[]            |
|  __________  |
|  | potato |  |
|  | system |  |
|  |________|  |
|   ________   |
|   [ [ ]  ]   |
\___[_[_]__]___|


EOF

args=$1

stop_potato() {
  docker-compose down --remove-orphans || true
}

after_start() {
  echo ""
  echo "Potato started correctly, printing Potato api logs"
  echo "you can close this and Potato will continue to run in backgound"
  echo ""
#  docker-compose logs -f api
}

if [[ $args == 'start' ]]; then
  stop_potato
  docker-compose up --force-recreate -d
  after_start
elif [[ $args == 'start:plex' ]]; then
  stop_potato
  docker-compose -f docker-compose.yml -f docker-compose.plex.yml up --force-recreate -d
  after_start
elif [[ $args == 'start:backup' ]]; then
  stop_potato
  docker-compose -f docker-compose.yml up --force-recreate -d;  tar -zcf restore/bazarr.tgz packages/bazarr/;tar -zcf restore/deluge-config.tgz packages/deluge/;tar -zcf restore/jacket-config.tgz packages/jackett/;tar -zcf restore/radarr-config.tgz packages/radarr/;tar -zcf restore/sonar-config.tgz packages/sonarr/
  after_start
elif [[ $args == 'start:restore' ]]; then
  stop_potato
  docker-compose -f docker-compose.yml up --force-recreate -d;  tar -xf restore/bazarr.tgz packages/bazarr/;tar -xf restore/deluge-config.tgz -C packages/deluge/;tar -xf restore/jacket-config.tgz -C packages/jackett/;tar -xf restore/radarr-config.tgz -C packages/radarr/;tar -xf restore/sonar-config.tgz -C packages/sonarr/
  after_start  
elif [[ $args == 'stop' ]]; then
  stop_potato
  echo ""
  echo "Potato correctly stopped"
elif [[ $args == 'update' ]]; then
  docker-compose pull
  echo ""
  echo "potato docker images correctly updated, you can now re-start potato"
else
  echo "unknow command: $args"
  echo "use [start | start:plex | start:backup | stop | update | start:restore]"
fi


