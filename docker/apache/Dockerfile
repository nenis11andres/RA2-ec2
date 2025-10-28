# Base Debian
FROM debian:bookworm

# Instalar Apache + PHP + extensiones necesarias
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mbstring php-xml php-pdo php-mysql unzip curl git && \
    apt-get clean

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Habilitar mod_rewrite para Symfony
RUN a2enmod rewrite

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar solo composer.json y composer.lock para instalar dependencias
COPY ../gym/composer.json ../gym/composer.lock ./
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Copiar resto del proyecto
COPY ../gym/public ./public
COPY ../gym/var ./var

# Dar permisos
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Copiar configuración de Apache
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2ctl", "-D", "FOREGROUND"]
