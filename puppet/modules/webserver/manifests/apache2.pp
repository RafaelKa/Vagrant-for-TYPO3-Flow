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

  # Configure Apache HTTPd to run PHP with FPM
#  file {'/etc/apache2/sites-available/default.vhost':
#    ensure  => file,
#    require => Package['apache2'],
#    content => template('templates/default.vhost.erb')
#  }

}