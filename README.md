PostgreSQL-kurssi
=================

Tämä projekti on PostgreSQL-kurssin käytännön osuus

## Asennus

Asenna aluksi seuraavat ohjelmat:
* [docker](https://docs.docker.com/engine/install/ubuntu/)
* [docker-compose](https://docs.docker.com/compose/install/)

### Lokaali asennus
1. Luo `.env`-tiedosto ottamalla mallia `.env.template` -tiedostosta projektin juureen ja laita siihen seuraavat muuttujat ja niille halutut arvot:
    ```properties
        #PostGIS
        PG_TAG=latest
        PG_DB=training
        PG_USER=
        PG_PASS=

        # PGAdmin
        PGA_TAG=latest
        PGADMIN_DEFAULT_EMAIL=
        PGADMIN_DEFAULT_PASSWORD=
    ```
1. Käynnistä tietokanta, pgadmin4 ja nginx komennolla `docker-compose up -d`.
Tässä kestää jonkin aikaa jos joudutaan hakemaan docker-imaget ja rakentamaan ne.

1. Nyt harjoitukset tulisi näkyä juuriosoitteessa [/](/) ja pgadmin osoiitteesa [/pgadmin](/pgadmin)
1. Avaa selain ja testaa

### Asennus tuotantoympäristöön (Testattu Ubuntu 18.04)
1. Varmistu, että instanssilla on tarpeeksi vapaata kiintolevytilaa (~20 Gt)
1. Kloonaa tämä repositorio esimerkiksi kansioon */home/ubuntu/pg-training*
1. Jatka [Lokaaline asennuksen](#-Lokaali-asennus) kohtien mukaan
1. Avaa instanssin ip- tai CNAME-osoite ja testaa toimivuutta

## Lisenssit
* Harjoitukset ja ratkaisut ovat lisensioitu lisenssillä [Creative Commons Nimeä 4.0](http://creativecommons.org/licenses/by/4.0/deed.fi) 
* [etunimet.csv](Harjoitukset/data/etunimet.csv) - muodostettu 24.08.2020 aineistosta [Etunimitilasto 2020-08-19](https://www.avoindata.fi/data/fi/dataset/none/resource/08c89936-a230-42e9-a9fc-288632e234f5), joka on jaettu lisenssillä: [Creative Commons Nimeä 4.0](http://creativecommons.org/licenses/by/4.0/deed.fi) 
* [tieliikenne_schema.sql](Harjoitukset/data/tieliikenne_schema.sql) - muodostettu 25.08.2020 aineistosta [Ajoneuvojen avoin data 5.8](http://trafiopendata.97.fi/opendata/TieliikenneAvoinData_5_8.zip), joka on jaettu lisenssillä: [Creative Commons Nimeä 4.0](http://creativecommons.org/licenses/by/4.0/deed.fi) 
* [audit_log.csv](Harjoitukset/data/audit_log.csv) on muodostettu [enterprisedb](https://www.enterprisedb.com/edb-docs/d/edb-postgres-advanced-server/user-guides/user-guide/12/EDB_Postgres_Advanced_Server_Guide.1.43.html) -sivun 
   esimerkeistä.
* [digiroad_uusimaa.zip](Harjoitukset/data/digiroad_uusimaa.zip) on muodostettu 7.10.2020 [Digiroad](https://vayla.fi/vaylista/aineistot/digiroad/aineisto)-aineistosta, joka on jaettu lisenssillä: [Creative Commons Nimeä 4.0](http://creativecommons.org/licenses/by/4.0/deed.fi) 
* [kunnat.zip](Harjoitukset/data/kunnat.zip) on muodostettu 7.10.2020 [Kuntapohjaiset tilastointialueet](https://www.stat.fi/org/avoindata/paikkatietoaineistot/kuntapohjaiset_tilastointialueet.html)
-aineistosta, joka on jaettu lisenssillä: [Creative Commons Nimeä 4.0](http://creativecommons.org/licenses/by/4.0/deed.fi) 
