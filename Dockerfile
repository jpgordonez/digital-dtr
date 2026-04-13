# ============================================================
# Stage 1: PHP / Composer dependencies
# ============================================================
FROM php:8.2-fpm-alpine AS composer-builder

RUN apk add --no-cache unzip git

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

# ============================================================
# Stage 2: Node.js asset build
# ============================================================
FROM node:20-alpine AS node-builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

# Copy source files needed for the Vite build
COPY resources/ resources/
COPY vite.config.js jsconfig.json postcss.config.js ./
COPY public/ public/

# Ziggy is imported from vendor/tightenco/ziggy — copy it from the composer stage
COPY --from=composer-builder /var/www/html/vendor/tightenco/ziggy ./vendor/tightenco/ziggy

RUN npm run build

# ============================================================
# Stage 3: Final runtime image
# ============================================================
FROM php:8.2-fpm-alpine

# ── System dependencies ──────────────────────────────────────
RUN apk add --no-cache \
    bash \
    curl \
    git \
    unzip \
    zip \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    oniguruma-dev \
    icu-dev \
    nginx \
    supervisor

# ── PHP extensions ───────────────────────────────────────────
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
 && docker-php-ext-install -j"$(nproc)" \
        pdo \
        pdo_mysql \
        mbstring \
        zip \
        gd \
        bcmath \
        opcache \
        pcntl \
        intl

# ── Application code ─────────────────────────────────────────
WORKDIR /var/www/html

COPY . .

# ── PHP dependencies from composer stage ─────────────────────
COPY --from=composer-builder /var/www/html/vendor vendor/

# ── Compiled front-end assets from node stage ────────────────
COPY --from=node-builder /app/public/build public/build/

# ── Laravel bootstrap ────────────────────────────────────────
RUN cp .env.example .env \
 && php artisan key:generate --force \
 && php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache \
 && mkdir -p storage/framework/{sessions,views,cache} \
                storage/logs \
                bootstrap/cache \
 && chown -R www-data:www-data storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

# ── nginx configuration ──────────────────────────────────────
RUN mkdir -p /run/nginx
COPY docker/nginx.conf /etc/nginx/nginx.conf

# ── supervisord configuration ────────────────────────────────
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3000

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
