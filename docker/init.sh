#!/bin/bash

/entrypoint.sh influxd &

sleep 10

influx -execute 'CREATE DATABASE pigeonhole'
influx -execute "CREATE USER pigeonhole WITH PASSWORD 'pigeonhole'" -database="pigeonhole"
influx -execute "CREATE USER pigeonhole_rw WITH PASSWORD 'SD5hsfdg8'" -database="pigeonhole"

/etc/init.d/cron start
/etc/init.d/anacron start

bundle exec shotgun --host 0.0.0.0

tail -f /dev/null
