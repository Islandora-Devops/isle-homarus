FROM islandora/isle-crayfish-base:latest

## ffmpeg 
# @see: https://packages.debian.org/buster/ffmpeg

RUN FFMPEG_PACKS="ffmpeg" && \
    apt-get update && \
    apt-get install --no-install-recommends -y $FFMPEG_PACKS && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Composer & Homarus
# @see: Composer https://github.com/composer/getcomposer.org/commits/master (replace hash below with most recent hash)
# @see: Homarus https://github.com/Islandora/Crayfish

ENV PATH=$PATH:$HOME/.composer/vendor/bin \
    COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_HASH=${COMPOSER_HASH:-b9cc694e39b669376d7a033fb348324b945bce05} \
    HOMARUS_BRANCH=dev

RUN curl https://raw.githubusercontent.com/composer/getcomposer.org/$COMPOSER_HASH/web/installer --output composer-setup.php --silent && \
    php composer-setup.php --filename=composer --install-dir=/usr/local/bin && \
    rm composer-setup.php && \
    mkdir -p /opt/crayfish && \
    git clone -b $HOMARUS_BRANCH https://github.com/Islandora/Crayfish.git /opt/crayfish && \
    composer install -d /opt/crayfish/Homarus && \
    chown -Rv www-data:www-data /opt/crayfish && \
    mkdir /var/log/islandora && \
    chown www-data:www-data /var/log/islandora && \
    a2dissite 000-default && \
    #echo "ServerName localhost" | tee /etc/apache2/conf-available/servername.conf && \
    #a2enconf servername && \
    a2enmod rewrite deflate headers expires proxy proxy_http proxy_html proxy_connect remoteip xml2enc cache_disk

COPY rootfs /

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="ISLE 8 Homarus Image" \
      org.label-schema.description="ISLE 8 Homarus" \
      org.label-schema.url="https://islandora.ca" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/Islandora-Devops/isle-homarus" \
      org.label-schema.vendor="Islandora Devops" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

WORKDIR /opt/crayfish/Homarus/
