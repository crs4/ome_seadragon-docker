FROM openmicroscopy/omero-web:5.4.10
LABEL maintainer="luca.lianas@crs4.it"

USER root

RUN yum -y install git gcc-c++ make openslide \
    && curl -sL https://rpm.nodesource.com/setup_8.x | bash - \
    && yum -y install nodejs \
    && npm install -g grunt
    
RUN mkdir /opt/ome_web_plugins/
WORKDIR /opt/ome_web_plugins/

RUN git clone https://github.com/crs4/ome_seadragon.git --branch master --single-branch --depth 1 \
    && chown -R omero-web /opt/ome_web_plugins/

ADD 80-configure-ome_seadragon.sh 81-configure-corsheaders.sh /startup/

USER omero-web

WORKDIR /opt/ome_web_plugins/ome_seadragon/
RUN npm install \
    && grunt

# TODO: update ome_seadragon repository in order to fix NPM problem
ADD package.json /opt/ome_web_plugins/ome_seadragon/

ENV PYTHONPATH "/opt/ome_web_plugins/:${PYTHONPATH}"

RUN pip install --user --upgrade pip openslide-python Pillow lxml requests django-cors-headers
