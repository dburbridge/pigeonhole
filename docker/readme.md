Steps to run:

- cd docker/
- docker build . -t pigeonhole
 -docker run -d -p 9393:9393 -v /var/lib/influxdb pigeonhole

- docker ps -f ancestor=pigeonhole -q
- Take this container id and then run:
- docker exec <container_id> bin/import_from_pd <YYYY-MM-DD>
- eg: "docker exec 416734c8987d bin/import_from_pd 2016-07-01"
- Import pagerduty incidents from specified date - 2016-07-01 in this instance:

