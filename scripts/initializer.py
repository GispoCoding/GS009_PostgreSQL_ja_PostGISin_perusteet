import codecs
import os
import sys
import zipfile
from pathlib import Path

import pandas as pd
import psycopg2
import requests
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from sqlalchemy import create_engine
from ipygis import get_connection_url

sys.path.insert(0, '.')

DATA_DIR = Path('Harjoitukset', 'data')


def create_koulutus_db():
    with psycopg2.connect(get_connection_url()) as conn:
        conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        with conn.cursor() as cur:
            try:
                cur.execute('CREATE DATABASE koulutus')
            except Exception:
                print("DB already exists")


def add_road_data():
    print("Adding road data")
    download_data(Path(DATA_DIR, 'TieliikenneAvoinData_5_8.zip'),
                  'http://trafiopendata.97.fi/opendata/TieliikenneAvoinData_5_8.zip', 'iso-8859-1')
    with psycopg2.connect(get_connection_url()) as conn:
        with conn.cursor() as cur:
            try:
                with open(Path(DATA_DIR, 'tieliikenne_schema.sql')) as f:
                    cur.execute(f.read())
                # noinspection SqlNoDataSourceInspection
                cur.execute('DELETE FROM tieliikenne')
                cur.execute(
                    "COPY tieliikenne FROM '/home/oppilas/pg-training/Harjoitukset/data/TieliikenneAvoinData_5_8_utf8.csv' WITH DELIMITER ';' CSV HEADER")
            except Exception as e:
                print("tieliikenne already exists or some other error: ", e)


def create_postgis_extension():
    with psycopg2.connect(get_connection_url()) as conn:
        with conn.cursor() as cur:
            try:
                # noinspection SqlNoDataSourceInspection
                cur.execute('CREATE EXTENSION IF NOT EXISTS postgis')
            except Exception as e:
                print("Postgis already exists", e)


def add_etunimi_data():
    print("Adding etunimi data")
    csv = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.path.pardir, 'Harjoitukset', 'data',
                       'etunimet.csv')
    add_csv_data(csv=csv, table_name="etunimet", sep=',', dbname='koulutus')


def add_digiroad_data():
    print("Adding digiroad data")
    sql_path = Path(DATA_DIR, 'digiroad_uusimaa.sql')
    if not sql_path.exists():
        unzip(DATA_DIR, Path(DATA_DIR, 'digiroad_uusimaa.zip'))
    execute_sql(sql_path)


def add_municipality_data():
    print("Adding municipality data")
    sql_path = Path(DATA_DIR, 'kunnat.sql')
    if not sql_path.exists():
        unzip(DATA_DIR, Path(DATA_DIR, 'kunnat.zip'))
    execute_sql(sql_path)


def execute_sql(sql_path):
    with psycopg2.connect(get_connection_url()) as conn:
        with conn.cursor() as cur:
            with open(sql_path) as f:
                try:
                    cur.execute(f.read())
                except Exception as e:
                    print("data already exists", e)


def add_csv_data(csv, table_name, sep=';', dbname=None):
    df = pd.read_csv(csv, sep=sep, index_col=False)
    df.columns = [c.lower() for c in df.columns]
    if not dbname:
        engine = create_engine(get_connection_url())
    else:
        engine = create_engine(get_connection_url(dbname=dbname))
    try:
        df.to_sql(table_name, engine, index=False)
    except ValueError as e:
        print(e)


def download_data(dataset: Path, url, encoding=None):
    if not dataset.exists():
        with requests.get(url, stream=True) as r:
            r.raise_for_status()
            with open(dataset, 'wb') as f:
                for chunk in r.iter_content(chunk_size=8192):
                    f.write(chunk)

    dataset_pth = str(dataset.resolve())
    utf_version = dataset_pth.replace('.zip', '_utf8.csv')
    if not os.path.exists(utf_version):
        if dataset.suffix.endswith("zip"):
            unzip(DATA_DIR, dataset)
        if encoding is not None:
            convert_to_utf8(dataset_pth.replace('.zip', '.csv'), utf_version, encoding)


def unzip(dst: Path, f: Path):
    os.makedirs(dst, exist_ok=True)
    with zipfile.ZipFile(f, 'r') as zip_ref:
        zip_ref.extractall(dst)


def convert_to_utf8(src: str, target: str, src_encoding):
    '''
    https://stackoverflow.com/a/191403/10068922
    '''
    BLOCKSIZE = 1048576  # or some other, desired size in bytes
    with codecs.open(src, "r", src_encoding) as sourceFile:
        with codecs.open(target, "w", "utf-8") as targetFile:
            while True:
                contents = sourceFile.read(BLOCKSIZE)
                if not contents:
                    break
                targetFile.write(contents)


def initialize_h7():
    create_koulutus_db()
    add_etunimi_data()


def main():
    print("Initializing")
    add_road_data()
    create_postgis_extension()
    add_digiroad_data()
    add_municipality_data()


if __name__ == '__main__':
    main()
