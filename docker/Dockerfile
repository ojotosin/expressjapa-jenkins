# Use the latest version of the Amazon Linux base image
FROM amazonlinux:2

# Update all installed packages to latest versions
RUN yum update -y

# Install the sudo package
RUN yum install -y sudo

# Install the unzip package
RUN yum install -y unzip

# Install wget package
RUN yum install -y wget

# Install Apache
RUN yum install -y httpd

# Install PHP 7.4 and required extensions
RUN yum install -y yum-utils
RUN amazon-linux-extras enable php7.4
RUN yum install -y \
    php \
    php-common \
    php-pear \
    php-cgi \
    php-curl \
    php-mbstring \
    php-pdo \
    php-gd \
    php-mysqlnd \
    php-gettext \
    php-json \
    php-xml \
    php-fpm \
    php-intl \
    php-zip

# Download the MySQL repository package
RUN wget https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm

# Import the GPG key for the MySQL repository
RUN rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022

# Install the MySQL repository package
RUN yum localinstall mysql80-community-release-el7-3.noarch.rpm -y

# Install the MySQL community server package
RUN yum install mysql-community-server -y

# Set permissions for directories in /var/www
RUN chmod 2775 /var/www && find /var/www -type d -exec chmod 2775 {} \;

# Set permissions for files in /var/www
RUN find /var/www -type f -exec chmod 0664 {} \;

# Change directory to the html directory
WORKDIR /var/www/html

# Install Git
RUN yum install -y git

# Set the build argument directive
ARG PERSONAL_ACCESS_TOKEN
ARG GITHUB_USERNAME
ARG REPOSITORY_NAME
ARG WEB_FILE_ZIP
ARG WEB_FILE_UNZIP
ARG DOMAIN_NAME
ARG RDS_DB_ENDPOINT
ARG RDS_DB_NAME
ARG RDS_MASTER_USERNAME
ARG RDS_DB_PASSWORD

# Use the build argument to set environment variables 
ENV PERSONAL_ACCESS_TOKEN=$PERSONAL_ACCESS_TOKEN
ENV GITHUB_USERNAME=$GITHUB_USERNAME
ENV REPOSITORY_NAME=$REPOSITORY_NAME
ENV WEB_FILE_ZIP=$WEB_FILE_ZIP
ENV WEB_FILE_UNZIP=$WEB_FILE_UNZIP
ENV RDS_DB_ENDPOINT=$RDS_DB_ENDPOINT
ENV RDS_DB_NAME=$RDS_DB_NAME
ENV RDS_MASTER_USERNAME=$RDS_MASTER_USERNAME
ENV RDS_DB_PASSWORD=$RDS_DB_PASSWORD

# Clone the GitHub repository
RUN git clone https://$PERSONAL_ACCESS_TOKEN@github.com/$GITHUB_USERNAME/$REPOSITORY_NAME.git

# Unzip the zip folder containing the web files
RUN unzip -o $REPOSITORY_NAME/$WEB_FILE_ZIP -d $REPOSITORY_NAME/

# Copy the web files (plus hidden files .htaccess and .editorconfig) into the HTML directory
RUN cp -avR $REPOSITORY_NAME/$WEB_FILE_UNZIP/. /var/www/html

# Remove the cloned repo
RUN rm -rf $REPOSITORY_NAME

# Enable the mod_rewrite setting in the httpd.conf file
RUN sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf

# Locate the PHP configuration file and enable allow_url_fopen
RUN php_ini_file=$(php -i | grep 'Loaded Configuration File' | awk '{print $5}') && \
    sed -i 's/;allow_url_fopen = Off/allow_url_fopen = On/g' "$php_ini_file"

# Enable MySQLi extension in the PHP configuration file
RUN echo "extension=mysqli" | sudo tee -a $php_ini_file > /dev/null

# Give full access to the /var/www/html directory
RUN chmod -R 777 /var/www/html

# Use the sed command to search the database.php file for a line that starts with 'hostname' ' and replace everything after the => character
RUN sudo sed -i "s/^[\t ]*'hostname'.*=.*$/'hostname' => '$RDS_DB_ENDPOINT',/" ./application/config/database.php

# Use the sed command to search the database.php file for a line that starts with DB_HOST= and replace everything after the => character
RUN sudo sed -i "s/^[\t ]*'database'.*=.*$/'database' => '$RDS_DB_NAME',/" ./application/config/database.php

# Use the sed command to search the database.php file for a line that starts with DB_DATABASE= and replace everything after the => character
RUN sudo sed -i "s/^[\t ]*'username'.*=.*$/'username' => '$RDS_MASTER_USERNAME',/" ./application/config/database.php 

# Use the sed command to search the database.php file for a line that starts with RDS_MASTER_USERNAME= and replace everything after the => character
RUN sudo sed -i "s/^[\t ]*'password'.*=.*$/'password' => '$RDS_DB_PASSWORD',/" ./application/config/database.php

# Expose the default Apache and MySQL ports
EXPOSE 80 3306

# Start Apache and MySQL
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
