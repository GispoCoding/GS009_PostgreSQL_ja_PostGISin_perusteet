#!/usr/bin/env bash

export PGHOST=dbhost
export PGUSER=postgres
export PGPASSWORD=$POSTGRES_PASS

until pg_isready -h $PGHOST
do 
    echo "Waiting database to start"
    sleep 1
done
echo "Database started"

# Tieliikenne
echo "Importing Tieliikenne data"
psql -d postgres -f /home/$LINUX_USER/data/ajoneuvorekisteri_schema.sql
if [ ! -f 'TieliikenneAvoinData_5_18.csv' ]; then
  if [ ! -f 'Ajoneuvorekisteri.zip' ]; then
    wget https://gispo-training-data.s3.eu-central-1.amazonaws.com/public/Ajoneuvorekisteri.zip
  fi
  unzip Ajoneuvorekisteri.zip
fi
psql -d postgres -c "TRUNCATE tieliikenne;"
psql -d postgres -c "\COPY tieliikenne FROM 'TieliikenneAvoinData_5_18.csv' WITH DELIMITER ';' ENCODING 'latin1' CSV HEADER;"

psql -d postgres -c "CREATE EXTENSION IF NOT EXISTS postgis;"
echo "Importing digiroad_uusimaa"
ogr2ogr -f PostgreSQL -overwrite -nln digiroad_uusimaa PG:"dbname=postgres" /home/$LINUX_USER/data/digiroad.gpkg digiroad_uusimaa
echo "Importing kunnat"
ogr2ogr -f PostgreSQL -overwrite -nln kunnat PG:"dbname=postgres" /home/$LINUX_USER/data/kunnat.gpkg kunnat

psql -d postgres -c "CREATE DATABASE koulutus_template IS_TEMPLATE true;"
psql -d koulutus_template -c "CREATE extension postgis;"
psql -d koulutus_template -c "CREATE TABLE etunimet (nimi text NOT NULL,lukumaara integer NOT NULL,sukupuoli text NOT NULL);"
psql -d koulutus_template -c "\COPY etunimet FROM '/home/student/data/etunimet.csv' WITH CSV HEADER;"
