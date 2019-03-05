FROM openmicroscopy/omero-web:5.4.10
LABEL maintainer="luca.lianas@crs4.it"

USER root

RUN yum -y install git gcc-c++ openslide \
    && curl -sL https://rpm.nodesource.com/setup_8.x | bash - \
    && yum -y install nodejs \
    && npm install -g grunt
    
RUN mkdir /opt/ome_web_plugins/
WORKDIR /opt/ome_web_plugins/

RUN git clone https://github.com/crs4/ome_seadragon.git --branch master --single-branch --depth 1 \
    && chown -R omero-web /opt/ome_web_plugins/

USER omero-web

WORKDIR /opt/ome_web_plugins/ome_seadragon/
RUN npm install \
    && grunt

RUN pip install --user --upgrade -r requirements.txt

USER root

ADD 70-enable-ome_seadragon.sh \
    71-enable-django_cors_headers.sh \
    80-create-ome-public-user.sh \
    81-setup-ome-public-user.sh \
    82-setup-redis-cache.sh /startup/

USER omero_web

ENV PYTHONPATH "/opt/ome_web_plugins/:${PYTHONPATH}"
