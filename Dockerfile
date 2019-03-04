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

# install ome_seadragon_cache and remove source files
WORKDIR /tmp
RUN git clone https://github.com/crs4/ome_seadragon_cache --branch master --single-branch --depth 1 \
    && cd ome_seadragon_cache \
    && pip install --user -r requirements.txt \
    && python setup.py install --user \
    && cd /tmp \
    && rm -rf ome_seadragon_cache

WORKDIR /opt/ome_web_plugins/ome_seadragon/
RUN npm install \
    && grunt

# TODO: update ome_seadragon repository in order to fix NPM problem
ADD package.json /opt/ome_web_plugins/ome_seadragon/

RUN pip install --user --upgrade pip openslide-python Pillow lxml \
    requests django-cors-headers

USER root

ADD 70-enable-ome_seadragon.sh \
    71-enable-django_cors_headers.sh \
    80-create-ome-public-user.sh \
    81-setup-ome-public-user.sh \
    82-setup-redis-cache.sh /startup/

USER omero_web

ENV PYTHONPATH "/opt/ome_web_plugins/:${PYTHONPATH}"
