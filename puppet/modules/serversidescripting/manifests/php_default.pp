class serversidescripting::php_default {

  package { [
    'php5',
    'php5-common',
    'php5-gd',
    'php5-mysql',
    'php5-imap',
    'phpmyadmin',
    'php5-cli',
    'php-pear',
    'php-auth',
    'php5-mcrypt',
    'mcrypt',
    'php5-imagick',
    'imagemagick',
    'php5-curl',
    'php5-intl',
    'php5-memcache',
    'php5-memcached',
    'php5-ming',
    'php5-ps',
    'php5-pspell',
#    'php5-recode',
    'php5-fpm',
    'php5-sqlite',
    'php5-tidy',
    'php5-xmlrpc',
    'php5-xsl',
    'memcached',
    'libexpat1',
    'ssl-cert'
  ]:
    ensure  => 'installed'
#    require => Apt::Ppa['ppa:ondrej/apache2']
  }

  exec { 'composer-install':
    command => 'mkdir -p /usr/share/php/composer; curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/share/php/composer; ln -s /usr/share/php/composer/composer.phar /usr/bin/composer',
    require => Package['php5-cli']
  }
  ->
  notify { 'composer-is-installed':
    message => 'composer "Dependency Manager for PHP" installed'
  }

}
