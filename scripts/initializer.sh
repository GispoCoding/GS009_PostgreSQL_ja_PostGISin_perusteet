#!/bin/bash

# https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/exercise2/readme.html
echo "Configuring nbextension"
jupyter contrib nbextension install --user
jupyter nbextension enable rubberband/main
jupyter nbextension enable exercise/main
jupyter nbextension enable exercise2/main

echo "Installing theme"
jt -t gispo -nf karla

echo "Copying theme"
cp /opt/conda/lib/python3.8/site-packages/jupyterthemes/styles/compiled/gispo.css /home/jovyan/.jupyter/custom/custom.css
cp /opt/conda/lib/python3.8/site-packages/jupyterthemes/styles/compiled/exercise2.css /home/jovyan/.local/share/jupyter/nbextensions/exercise2/main.css

echo "Replacing login page"
wget --output-document='/home/jovyan/login.html'  https://raw.githubusercontent.com/GispoCoding/jupyter-themes/master/jupyterthemes/styles/compiled/login.html
cp /home/jovyan/login.html /opt/conda/lib/python3.8/site-packages/notebook/templates/login.html
sed -i 's/Otsikko/PostgreSQL-kurssi/g' /opt/conda/lib/python3.8/site-packages/notebook/templates/login.html
sed -i 's/sisältö/Tämä on PostgreSQL-kurssin käytännön osuus ja se koostuu Jupyter Notebook harjoituksista./g' /opt/conda/lib/python3.8/site-packages/notebook/templates/login.html

echo "Waiting for postgres..."
while ! nc -z $PGHOST 5432; do
  sleep 0.1
done

echo "PostgreSQL started, initializing"
cd /home/"$NB_USER"/pg-training || exit
python scripts/initializer.py
cd /home/oppilas/pg-training/Harjoitukset || exit
