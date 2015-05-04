class tools::phpmyadmin {

  exec { 'download-and-extract-PhpMyAdmin':
    command => 'wget http://sourceforge.net/projects/phpmyadmin/files/latest/download -O phpmyadmin-latest.zip \
                && unzip phpmyadmin-latest.zip -d /var/www/tools/ \
                && mv /var/www/tools/phpMyAdmin-*-all-languages /var/www/tools/phpmyadmin \
                && rm phpmyadmin-latest.zip',
    require => [ File['/var/www/tools'], Package['unzip'] ],
    timeout => 600,
    creates => '/var/www/tools/phpmyadmin'
  }
  ->
  notify { 'PhpMyAdmin-downloaded':
    message => 'phpMyAdmin is downloaded'
  }

  file { '/var/www/tools/phpmyadmin/config.inc.php':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => [ Exec['download-and-extract-PhpMyAdmin'] ],
    content => template('tools/phpMyAdmin.config.inc.php.erb')
  }
  ->
  notify { 'phpmyadmin-configuration-applied':
    message => 'configuration for PhpMyAdmin'
  }

  # Configure Apache HTTPd to run PhpMyAdmin with FPM
  file { '/etc/apache2/conf-available/phpMyAdmin.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => [ Exec['restart-apache2'], Package['apache2'] ],
    content => template('tools/phpMyAdmin.Apache2.conf.erb')
  }
  ->
  notify { 'phpmyadmin-configuration-for-apache-applied':
    message => 'Apaches configuration for running PhpMyAdmin applied'
  }

  exec { 'enable-Apaches-config-for-phpMyAdmin':
    command => 'a2enconf phpMyAdmin && service apache2 reload',
    require => File['/etc/apache2/conf-available/phpMyAdmin.conf'],
    creates => '/etc/apache2/conf-enabled/phpMyAdmin.conf'
  }

}