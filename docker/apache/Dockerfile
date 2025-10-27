# Base Debian
FROM debian:bookworm

# Apache + PHP + extensiones
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mbstring php-xml php-pdo php-mysql unzip curl git && \
    apt-get clean

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Copiar proyecto Symfony desde la raíz del repositorio
COPY gym /var/www/html

# Copiar configuración de Apache
COPY docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Exponer puerto 80
EXPOSE 80

CMD ["apache2ctl", "-D", "FOREGROUND"]
