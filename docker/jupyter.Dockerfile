FROM jupyter/minimal-notebook:b2562c469cdd

USER root

RUN apt-get update && apt-get install -yq gnupg2 lsb-core
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list

RUN apt-get update \
    && apt-get install -yq postgresql-client

USER $NB_UID

COPY requirements.txt /tmp/

RUN pip install --requirement /tmp/requirements.txt && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

