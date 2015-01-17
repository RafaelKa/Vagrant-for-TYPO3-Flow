class webserver::apache2 {

  apt::ppa { 'ppa:ondrej/apache2':}

  package { 'apache2':
    ensure  => 'latest',
    require => Apt::Ppa['ppa:ondrej/apache2']
  }

  exec {'enabling mod_proxy_fcgi':
    command => 'a2enmod proxy_fcgi',
    require => Package['apache2']
  }
  ->
  notify { 'enable mod_proxy_fcgi':
    message => 'mod_proxy_fcgi enabled'
  }

  exec {'enabling mod_rewrite':
    command => 'a2enmod rewrite',
    require => Package['apache2']
  }
  ->
  notify { 'enable mod_rewrite':
    message => 'mod_rewrite enabled'
  }

  #  exec {'disabling mod_':
  #    command => 'a2enmod proxy_fcgi',
  #    require => Package['apache2']
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
      require => Package['apache2']
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

  # Configure Apache HTTPd to run PHP with FPM
  file { 'apache-default-host':
    path => '/etc/apache2/sites-available/000-default.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => Package['apache2'],
    content => template('templates/default.vhost.erb')
  }
  ->
  notify { 'mass-vhost-configuration-applied':
    message => 'mass hosting configuration for Apache HTTPd applied'
  }

}