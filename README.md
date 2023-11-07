PostgreSQL ja PostGISin perusteet -kurssi
=================

Tämä projekti on PostgreSQL ja PostGISin perusteet -kurssin käytännön osuus

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

### Koulutusmateriaalin muokkaus
Materiaaleja voi muokata joko käyttäen RStudiota, jolloin päivityksiä on helpompi/nopeampi seurata. Tai sitten muokkausta voi tehdä myös omalla IDE:llä/editorilla, jolloin kääntämisen voi tehdä docker-kontissa.

**RStudio**
1. Asenna R ja RStudio
2. Tee muokkaukset  `harjoitukset` kansiosta löytyviin `*.rmd` tiedostoihin
3. Käännä kirja `Build book` napilla

**Docker**
1. Tee muokkaukset  `harjoitukset` kansiosta löytyviin `*.rmd` tiedostoihin
2. Aja `docker compose up bookdown`
3. Siirry kometorivillä `harjoitukset/build` kansioon ja käynnistä http-serveri `python -m http.server`
4. Mene selaimella osoitteeseen `localhost:8000`
   
### Ratkaisuavaimet

Katso [/tokens.md](/tokens.md)

## Lisenssit
Harjoitusmateriaalit on julkaistu avoimella lisenssillä. Käytettävä lisenssi on [Creative Commons Nimeä-EiMuutoksia 4.0](https://creativecommons.org/licenses/by-nd/4.0/deed.fi).

Harjoituksissa käytettävät aineistot:

*    1_milj_Shape_etrs_shape.zip - ladattu 5.7.2023 Maanmittauslaitoksen Karttapaikasta (Maastokartta 1:1 000 000). Jaettu lisenssillä Creative Commons Nimeä 4.0
*    airports.dat - ladattu Openflights- sivustolta. Lentokenttäaineisto on julkista (public domain).
