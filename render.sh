#!/usr/bin/env bash

docker run --rm -v "$(pwd)/harjoitukset:/book" -v "$(pwd)/data:/data" gispo/bookdown
