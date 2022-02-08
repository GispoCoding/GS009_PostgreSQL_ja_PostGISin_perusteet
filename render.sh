#!/usr/bin/env bash

docker run --rm -v "$(pwd)/harjoitukset:/app" mvaaltola/bookdown:latest ./_build.sh
