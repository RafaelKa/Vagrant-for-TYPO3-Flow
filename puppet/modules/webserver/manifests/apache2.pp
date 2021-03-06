class webserver::apache2 {

  apt::ppa { 'ppa:ondrej/apache2':
    before => Exec['apt-update']
  }

  package { 'apache2':
    ensure  => 'latest',
    require => Apt::Ppa['ppa:ondrej/apache2']
  }

  exec {'enabling-mod_proxy_fcgi':
    command => 'a2enmod proxy_fcgi',
    require => Package['apache2'],
    creates => '/etc/apache2/mods-enabled/proxy_fcgi.load'
  }
  ->
  notify { 'enable-mod_proxy_fcgi':
    message => 'Apaches mod proxy_fcgi enabled'
  }

  exec {'enabling-mod_rewrite':
    command => 'a2enmod rewrite',
    require => Package['apache2'],
    creates => '/etc/apache2/mods-enabled/rewrite.load'
  }
  ->
  notify { 'enable-mod_rewrite':
    message => 'Apaches mod rewrite enabled'
  }

  exec {'enabling-mod_vhost_alias':
    command => 'a2enmod vhost_alias',
    require => Package['apache2'],
    creates => '/etc/apache2/mods-enabled/vhost_alias.load'
  }
  ->
  notify { 'enable-mod_vhost_alias':
    message => 'Apaches mod vhost_alias enabled'
  }

#  exec {'change-owner-for-var_www':
#    command => 'chown -R www-data:www-data /var/www',
#    require => Package['apache2']
#  }
#  ->
#  notify { 'change-owner-for-var_www':
#    message => 'set www-data as owner from /var/www/'
#  }

  $settings = hiera('webserver')
  if $settings['Apache']['autostart'] == true {
    exec { 'enable-autostart-for-apache-httpd':
      command => 'update-rc.d apache2 defaults',
      require => Package['apache2']
    }
    ->
    exec { 'start-apache-httpd-server':
      command => 'service apache2 start'
    }
    ->
    notify { 'apache2-enable-autostart':
      message => 'autostart for Apache HTTPd enabled and Apache HTTPd server started'
    }
  } else {
    exec { 'disable-autostart-for-apache2':
      command => 'update-rc.d -f apache2 remove',
      require => Package['apache2'],
      onlyif => 'ls /etc/rc*.d | grep apache2'
    }
    ->
    exec { 'stop-apache-httpd-server':
      command => 'service apache2 stop'
    }
    ->
    notify { 'apache2-disable-autostart':
      message => 'autostart for Apache HTTPd disabled and Apache HTTPd server stopped'
    }
  }
}