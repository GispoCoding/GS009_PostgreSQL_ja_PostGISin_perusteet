#!/usr/bin/env bash

wget https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat -O data/client/airports.dat
docker-compose run --rm client ./initializer.sh
