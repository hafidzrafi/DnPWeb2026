FROM php:8.3-fpm-alpine

ARG UID=1000
ARG GID=1000

# Install build dependencies & essential system utilities
RUN apk update && apk add --no-cache \
    libpq-dev \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    oniguruma-dev \
    postgresql-client \
    mariadb-client \
    git \
    curl \
    unzip \
    zip \
    shadow

# Configure and compile core PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_pgsql \
        pgsql \
        pdo_mysql \
        mysqli \
        gd \
        intl \
        zip \
        bcmath \
        exif \
        opcache

# Copy official Composer binary (Multi-stage build)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy custom PHP & Opcache configurations
COPY docker/php/conf.d/custom.ini /usr/local/etc/php/conf.d/99-custom.ini
COPY docker/php/conf.d/opcache.ini /usr/local/etc/php/conf.d/99-opcache.ini

# Ensure www-data user matches host UID/GID to avoid permission issues
RUN usermod -u ${UID} www-data && groupmod -g ${GID} www-data

WORKDIR /var/www/html

USER www-data

EXPOSE 9000

CMD ["php-fpm"]
