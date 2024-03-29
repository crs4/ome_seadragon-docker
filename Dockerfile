FROM openmicroscopy/omero-web:5.11
LABEL maintainer="luca.lianas@crs4.it"

USER root

RUN yum -y install gcc-c++ openslide wget unzip python3-devel \
    && curl -sL https://rpm.nodesource.com/setup_10.x | bash - \
    && yum -y install nodejs \
    && npm install -g grunt

ARG OME_SEADRAGON_VERSION=0.8.5

RUN mkdir /opt/ome_web_plugins/ \
    && wget https://github.com/crs4/ome_seadragon/archive/v${OME_SEADRAGON_VERSION}.zip -P /opt/ome_web_plugins/ \
    && unzip /opt/ome_web_plugins/v${OME_SEADRAGON_VERSION}.zip -d /opt/ome_web_plugins/ \
    && mv /opt/ome_web_plugins/ome_seadragon{-${OME_SEADRAGON_VERSION},} \
    && rm /opt/ome_web_plugins/v${OME_SEADRAGON_VERSION}.zip \
    && chown -R omero-web /opt/ome_web_plugins/

WORKDIR /opt/ome_web_plugins/ome_seadragon/

USER root

RUN /opt/omero/web/venv3/bin/pip install --upgrade pip \
    && /opt/omero/web/venv3/bin/pip install --upgrade -r requirements.txt

USER omero-web

RUN npm install \
    && grunt

USER root

RUN mkdir -p /data/array_datasets \
    && chown -R omero-web /data/array_datasets/

COPY resources/wait-for-it.sh /usr/local/bin/

COPY resources/40-wait-for-omero.sh \
     resources/70-enable-ome_seadragon.sh \
     resources/71-enable-django_cors_headers.sh \
     resources/80-create-ome-public-user.sh \
     resources/81-setup-ome-public-user.sh \
     resources/82-setup-redis-cache.sh \
     resources/83-setup-images-repository.sh \
     resources/84-setup-default-group.sh \
     resources/85-setup-gateway-user.sh \
     resources/86-setup-rendering-engines.sh \
     resources/87-setup-deepzoom-properties.sh \
     resources/88-setup-datasets-repository.sh \
     resources/90-default-web-config-2.sh /startup/

USER omero-web

ENV PYTHONPATH "/opt/ome_web_plugins/:${PYTHONPATH}"
