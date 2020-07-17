FROM php:7.3
LABEL maintainer="markus@martialblog.de"
ARG composer_sha384='48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5'
ARG composer_version='1.10.9'
ARG checker_sha256='cacaa0bf6942d05d31dc35755d45706b6466dbabdb7dffe9e41b50e2991e7959'
ARG cs_fixer_version='v2.15.8'
ARG cs_fixer_sha256='dbcd1dc2c53552fd458c2f78f989ee5f05b116a497d815cb3af5aa547e34e1bf'

# OS Dependencies
RUN set -ex; \
        apt-get update && \
        DEBIAN_FRONTEND=noninteractive \
        apt-get install --no-install-recommends -y \
        \
        git \
        libldap2-dev \
        libjpeg-dev \
        libpng-dev \
        \
        && apt-get -y autoclean; apt-get -y autoremove; \
        rm -rf /var/lib/apt/lists/*

# PHP security-checker
RUN set -ex; \
        curl --silent --fail --location --retry 3 --output /tmp/security-checker https://get.sensiolabs.org/security-checker.phar ; \
        echo "${checker_sha256}  /tmp/security-checker" | sha256sum -c - && \
        cp /tmp/security-checker /usr/bin/ ; chmod +x /usr/bin/security-checker; \
        security-checker --version; \
        rm -f /tmp/security-checker

# PHP cs-fixer
RUN set -eux; \
        curl --silent --fail --location --retry 3 --output /tmp/php-cs-fixer "https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/${cs_fixer_version}/php-cs-fixer.phar" ; \
        echo "${cs_fixer_sha256}  /tmp/php-cs-fixer" | sha256sum -c - && \
        cp /tmp/php-cs-fixer /usr/bin/ ; chmod +x /usr/bin/php-cs-fixer ; \
        php-cs-fixer --version ; \
        rm -f /tmp/php-cs-fixer

# PHP Composer
RUN set -eux; \
        curl --silent --fail --location --retry 3 --output /tmp/installer.php --url https://raw.githubusercontent.com/composer/getcomposer.org/cb19f2aa3aeaa2006c0cd69a7ef011eb31463067/web/installer; \
        echo "${composer_sha384}  /tmp/installer.php" | sha384sum -c - && \
        \
        php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer --version=${composer_version}; \
        composer --ansi --version --no-interaction; \
        rm -f /tmp/installer.php

# PHP Dependencies
RUN set -ex; \
        pecl install xdebug-2.9.6; docker-php-ext-enable xdebug && \
        docker-php-ext-install -j5 \
        exif \
        ldap \
        gd
