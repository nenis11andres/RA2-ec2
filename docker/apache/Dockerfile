# Base Debian
FROM debian:bookworm

# Instalar Apache + PHP + extensiones necesarias
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mbstring php-xml php-pdo php-mysql unzip curl git && \
    apt-get clean

# Habilitar mod_rewrite para Symfony
RUN a2enmod rewrite

# Copiar proyecto Symfony completo, incluyendo archivos ocultos (.htaccess)
COPY gym/. /var/www/html/

# Copiar configuración de Apache
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Asegurar permisos correctos para Apache
RUN chown -R www-data:www-data /var/www/html

# Exponer puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2ctl", "-D", "FOREGROUND"]
