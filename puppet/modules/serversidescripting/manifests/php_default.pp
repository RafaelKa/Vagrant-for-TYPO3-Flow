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

  $settings = hiera('serversidescripting')
  exec { 'set-datetimezone-for-php':
    # todo : use $settings['php']['default']['timezone']
    command => 'perl -pi -e \'s/^;date\.timezone =/date\.timezone = "UTC"/g;\' /etc/php5/*/php.ini',
    require => [ Package['php5-cli'], Package['php5-fpm']]
  }
  ->
  notify { 'datetimezone-for-php-is-set':
    message => 'Timezone for PHP changed to UTC.'
  }

  exec { 'set-memory_limit-to-512M-for-php-fpm':
    command => 'perl -pi -e \'s/^memory_limit = 128M/memory_limit = 512M/g;\' /etc/php5/fpm/php.ini',
    require => [ Package['php5-fpm']]
  }
  ->
  notify { 'memory_limit-for-php-fpm-set':
    message => 'Memory limit for PHP-FPM is set to 512M'
  }

  # Composer

  exec { 'composer-install':
    command => 'mkdir -p /usr/share/php/composer; curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/share/php/composer',
    require => Package['php5-cli'],
    creates => '/usr/share/php/composer'
  }
  ->
  notify { 'composer-is-installed':
    message => 'composer "Dependency Manager for PHP" installed in /usr/share/php/composer/ direcory'
  }

  exec { 'create-symlink-to-composer-in-path-directory':
    command => 'ln -s /usr/share/php/composer/composer.phar /usr/bin/composer',
    require => Exec['composer-install'],
    creates => '/usr/bin/composer'
  }
  ->
  notify { 'created-symlink-to-composer-in-path-directory':
    message => 'Symlink /usr/bin/composer for composer.phar created. You can run "composer" command everywhere.'
  }

  exec { 'composer-update-script':
    command => 'echo \'#!/bin/bash\n/usr/share/php/composer/composer.phar self-update\' > /usr/bin/composer-self-update; chmod 750 /usr/bin/composer-self-update',
    require => Exec['composer-install'],
    creates => '/usr/bin/composer-self-update'
  }
  ->
  notify { 'composer-update-script-created':
    message => 'Update script for composer "Dependency Manager for PHP" created. Run "sudo composer-self-update" to update composer.'
  }

}
