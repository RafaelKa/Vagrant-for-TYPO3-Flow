class hosting::apache {
  # Configure Apache HTTPd to run PHP with FPM
  file { '/etc/apache2/sites-available/000-default.conf':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    ensure  => file,
    require => Package['apache2'],
    content => template('hosting/apache.default.vhost.erb')
  }
  ->
  exec {'restart-apache2':
    command => 'service apache2 restart'
  }
  ->
  notify { 'mass-vhost-configuration-applied':
    message => 'mass hosting configuration for Apache HTTPd applied'
  }
}